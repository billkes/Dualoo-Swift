#!/usr/bin/env python3
"""Deny Agent reads/shell that escape the Cursor workspace root(s).

Used by project ``.cursor/hooks.json``:
  - beforeReadFile
  - beforeShellExecution
  - preToolUse (Read|Shell|Grep)

Exit 0 always when JSON is returned; use permission deny to block.
failClosed is set on the hook definition so crashes block too.
"""

from __future__ import annotations

import json
import os
import re
import sys
from pathlib import Path

# Absolute paths and quoted path-like tokens in shell commands.
_ABS_PATH_RE = re.compile(r"(?:^|[\s\"'=])(/[^\s\"']+)")
_OUTPUT_PACK_RE = re.compile(
    r"/output/[A-Za-z][A-Za-z0-9]*-(?:Swift|OC|Flutter)(?:/|$)"
)


def _workspace_roots(payload: dict) -> list[Path]:
    roots: list[Path] = []
    for raw in payload.get("workspace_roots") or []:
        try:
            roots.append(Path(str(raw)).expanduser().resolve())
        except OSError:
            continue
    env = os.environ.get("CURSOR_PROJECT_DIR") or os.environ.get("CLAUDE_PROJECT_DIR")
    if env:
        try:
            roots.append(Path(env).expanduser().resolve())
        except OSError:
            pass
    # Dedupe
    out: list[Path] = []
    seen: set[Path] = set()
    for r in roots:
        if r not in seen:
            seen.add(r)
            out.append(r)
    return out


def _is_inside(path: Path, roots: list[Path]) -> bool:
    try:
        resolved = path.expanduser().resolve()
    except OSError:
        return False
    for root in roots:
        try:
            resolved.relative_to(root)
            return True
        except ValueError:
            continue
    return False


def _deny(user_message: str, agent_message: str | None = None) -> dict:
    body: dict = {
        "permission": "deny",
        "user_message": user_message,
    }
    if agent_message:
        body["agent_message"] = agent_message
    return body


def _allow() -> dict:
    return {"permission": "allow"}


def _paths_from_shell(command: str) -> list[Path]:
    found: list[Path] = []
    for m in _ABS_PATH_RE.finditer(command or ""):
        token = m.group(1).rstrip("\"'`")
        # Trim trailing punctuation from shell
        token = token.rstrip(");,")
        if not token.startswith("/"):
            continue
        found.append(Path(token))
    return found


def _handle_before_read(payload: dict, roots: list[Path]) -> dict:
    raw = payload.get("file_path") or ""
    if not raw:
        return _allow()
    path = Path(str(raw))
    if _is_inside(path, roots):
        return _allow()
    return _deny(
        f"Blocked read outside workspace: {raw}",
        "Path is outside workspace_roots; do not retry with absolute paths "
        "to sibling packs, Desktop, or other repos.",
    )


def _handle_before_shell(payload: dict, roots: list[Path]) -> dict:
    command = str(payload.get("command") or "")
    if not command.strip():
        return _allow()
    offenders: list[str] = []
    for path in _paths_from_shell(command):
        if not _is_inside(path, roots):
            offenders.append(str(path))
    # Also catch relative ../ escapes that resolve outside
    if ".." in command:
        cwd = Path(str(payload.get("cwd") or roots[0] if roots else ".")).resolve()
        for part in re.findall(r"(?:\.\./)+[^\s\"']*", command):
            try:
                cand = (cwd / part).resolve()
            except OSError:
                continue
            if roots and not _is_inside(cand, roots):
                offenders.append(str(cand))
    if offenders:
        joined = ", ".join(offenders[:5])
        return _deny(
            f"Blocked shell path outside workspace: {joined}",
            "Shell command referenced paths outside workspace_roots; "
            "rewrite to stay inside the package git root.",
        )
    return _allow()


def _handle_pre_tool(payload: dict, roots: list[Path]) -> dict:
    tool = str(payload.get("tool_name") or "")
    tool_input = payload.get("tool_input")
    if not isinstance(tool_input, dict):
        tool_input = {}
    if tool == "Read":
        path = tool_input.get("path") or tool_input.get("file_path") or ""
        if path and not _is_inside(Path(str(path)), roots):
            return _deny(
                f"Blocked Read outside workspace: {path}",
                "Read target is outside workspace_roots.",
            )
    if tool in ("Grep", "Glob"):
        path = tool_input.get("path") or tool_input.get("target_directory") or ""
        if path and str(path).startswith("/") and not _is_inside(Path(str(path)), roots):
            return _deny(
                f"Blocked {tool} outside workspace: {path}",
                f"{tool} path is outside workspace_roots.",
            )
    if tool == "Shell":
        return _handle_before_shell(
            {"command": tool_input.get("command") or "", "cwd": tool_input.get("working_directory") or payload.get("cwd")},
            roots,
        )
    return _allow()


def main() -> int:
    log_path = Path(
        os.environ.get("H5_DENY_HOOK_LOG")
        or "/tmp/h5-deny-outside-workspace.log"
    )
    try:
        payload = json.load(sys.stdin)
    except json.JSONDecodeError:
        # failClosed on definition will block; still emit deny
        print(json.dumps(_deny("Invalid hook input JSON")))
        return 2

    if not isinstance(payload, dict):
        print(json.dumps(_deny("Invalid hook payload")))
        return 2

    try:
        with log_path.open("a", encoding="utf-8") as fh:
            fh.write(
                json.dumps(
                    {
                        "event": payload.get("hook_event_name"),
                        "file_path": payload.get("file_path"),
                        "tool_name": payload.get("tool_name"),
                        "command": (payload.get("command") or "")[:200],
                        "workspace_roots": payload.get("workspace_roots"),
                    },
                    ensure_ascii=False,
                )
                + "\n"
            )
    except OSError:
        pass

    roots = _workspace_roots(payload)
    event = str(payload.get("hook_event_name") or "")

    if not roots:
        # Cannot enforce workspace boundary without roots — deny absolute
        # sibling-looking paths under /output/*-(Swift|OC|Flutter)/ as fallback.
        if event in ("beforeReadFile", "") and payload.get("file_path"):
            fp = str(payload.get("file_path") or "")
            if _OUTPUT_PACK_RE.search(fp):
                print(
                    json.dumps(
                        _deny(
                            f"Blocked read without workspace_roots: {fp}",
                            "workspace_roots missing; refusing /output/* pack paths.",
                        ),
                        ensure_ascii=False,
                    )
                )
                return 2
        if event == "beforeShellExecution" and _OUTPUT_PACK_RE.search(
            str(payload.get("command") or "")
        ):
            print(
                json.dumps(
                    _deny(
                        "Blocked shell without workspace_roots referencing /output/* pack",
                        "workspace_roots missing; refuse pack-path shell.",
                    ),
                    ensure_ascii=False,
                )
            )
            return 2
        print(json.dumps(_allow()))
        return 0

    if event == "beforeReadFile":
        result = _handle_before_read(payload, roots)
    elif event == "beforeShellExecution":
        result = _handle_before_shell(payload, roots)
    elif event == "preToolUse":
        result = _handle_pre_tool(payload, roots)
    else:
        # Unknown event: apply read+shell heuristics
        if payload.get("file_path"):
            result = _handle_before_read(payload, roots)
        elif payload.get("command"):
            result = _handle_before_shell(payload, roots)
        else:
            result = _handle_pre_tool(payload, roots)

    print(json.dumps(result, ensure_ascii=False))
    return 2 if result.get("permission") == "deny" else 0


if __name__ == "__main__":
    raise SystemExit(main())
