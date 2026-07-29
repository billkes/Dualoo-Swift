#!/usr/bin/env bash
# Fixed-stage screenshot for agent.html preview pages (390×844).
# OFFLINE: page must not depend on CDN (Tailwind / Google Fonts). Use file://.
#
# Usage: _shot.sh <html-file-or-url> <out-png>
# Optional env:
#   CHROME_BIN=/path/to/chrome
#   CHROME_USER_DATA_DIR=/path/to/writable-profile  (default: <pages>/.chrome-ud)
set -euo pipefail

SRC="${1:?usage: _shot.sh <html-or-url> <out-png>}"
OUT="${2:?usage: _shot.sh <html-or-url> <out-png>}"
W=390
H=844

resolve_chrome() {
  if [[ -n "${CHROME_BIN:-}" && -x "${CHROME_BIN}" ]]; then
    echo "${CHROME_BIN}"
    return 0
  fi
  local candidates=(
    "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
    "/Applications/Chromium.app/Contents/MacOS/Chromium"
    "/usr/bin/google-chrome-stable"
    "/usr/bin/google-chrome"
    "/usr/bin/chromium"
    "/usr/bin/chromium-browser"
    "/snap/bin/chromium"
  )
  local c
  for c in "${candidates[@]}"; do
    if [[ -x "$c" ]]; then
      echo "$c"
      return 0
    fi
  done
  # Playwright / sparticuz-style caches (optional; may exist in CI or web agents)
  local found
  found="$(compgen -G "${HOME}/.cache/ms-playwright/chromium-*/chrome-linux/chrome" 2>/dev/null | head -1 || true)"
  if [[ -n "$found" && -x "$found" ]]; then
    echo "$found"
    return 0
  fi
  found="$(compgen -G "${HOME}/Library/Caches/ms-playwright/chromium-*/chrome-mac/Chromium.app/Contents/MacOS/Chromium" 2>/dev/null | head -1 || true)"
  if [[ -n "$found" && -x "$found" ]]; then
    echo "$found"
    return 0
  fi
  if [[ -x /tmp/chromium ]]; then
    echo /tmp/chromium
    return 0
  fi
  return 1
}

if ! CHROME_BIN="$(resolve_chrome)"; then
  echo "error: no Chrome/Chromium binary found." >&2
  echo "  Set CHROME_BIN to a local browser (preferred on macOS:" >&2
  echo "  /Applications/Google Chrome.app/Contents/MacOS/Google Chrome)." >&2
  echo "  Do NOT use Pillow/synthetic placeholders; do NOT mark APPROVAL PASS." >&2
  exit 1
fi

if [[ "$SRC" != file://* && "$SRC" != http* && "$SRC" != https* ]]; then
  if [[ "$SRC" == *\?* ]]; then
    FILE="${SRC%%\?*}"
    QS="${SRC#*\?}"
    ABS="$(cd "$(dirname "$FILE")" && pwd)/$(basename "$FILE")"
    SRC="file://${ABS}?${QS}"
  else
    ABS="$(cd "$(dirname "$SRC")" && pwd)/$(basename "$SRC")"
    SRC="file://${ABS}"
  fi
fi

DIR="$(cd "$(dirname "$OUT")" && pwd)"
BASE="$(basename "$OUT")"
OUTPATH="${DIR}/${BASE}"
mkdir -p "$DIR"

# Writable profile inside the pages dir (sandbox-friendly)
PAGES_DIR="$(cd "$(dirname "$0")" && pwd)"
UD="${CHROME_USER_DATA_DIR:-${PAGES_DIR}/.chrome-ud}"
mkdir -p "$UD"

echo "shot: chrome=${CHROME_BIN}"
echo "shot: src=${SRC}"
echo "shot: out=${OUTPATH}"

# Real browser paint only — never fall back to Pillow/wireframe fakes.
# --disable-remote-fonts: preview pages must be offline (system/local fonts).
attempt=1
max_attempts=3
while [[ "$attempt" -le "$max_attempts" ]]; do
  rm -f "$OUTPATH"
  set +e
  "$CHROME_BIN" \
    --headless=new \
    --disable-gpu \
    --no-sandbox \
    --disable-dev-shm-usage \
    --hide-scrollbars \
    --disable-remote-fonts \
    --force-device-scale-factor=1 \
    --window-size="${W},${H}" \
    --user-data-dir="${UD}" \
    --virtual-time-budget=6000 \
    --screenshot="${OUTPATH}" \
    "$SRC"
  rc=$?
  set -e
  if [[ "$rc" -eq 0 && -f "$OUTPATH" ]]; then
    break
  fi
  echo "warn: chrome shot attempt ${attempt}/${max_attempts} failed (rc=${rc})" >&2
  attempt=$((attempt + 1))
  sleep 1
done

if [[ ! -f "$OUTPATH" ]]; then
  echo "error: screenshot not written: ${OUTPATH}" >&2
  echo "error: fix Chrome/CHROME_BIN/sandbox — do NOT synthesize PNGs with Pillow." >&2
  exit 1
fi

# Hard size check (fail = re-author HTML / chrome flags; never center-crop)
python3 - "$OUTPATH" "$W" "$H" <<'PY'
import sys
from pathlib import Path

path = Path(sys.argv[1])
tw, th = int(sys.argv[2]), int(sys.argv[3])
try:
    from PIL import Image
except ImportError:
    print(f"Wrote {path} (Pillow missing; skip size check)", flush=True)
    raise SystemExit(0)

im = Image.open(path)
w, h = im.size
# Reject obvious synthetic wireframes (near-empty / tiny files handled above)
if path.stat().st_size < 8_000:
    print(f"error: shot too small ({path.stat().st_size} bytes) — likely blank/failed paint", file=sys.stderr)
    raise SystemExit(2)
if (w, h) != (tw, th):
    print(f"error: shot size {w}x{h} != {tw}x{th} — fix HTML .stage or Chrome DPI; do NOT center-crop", file=sys.stderr)
    raise SystemExit(3)
print(f"OK {tw}x{th}")
print(f"Wrote {path}")
PY
