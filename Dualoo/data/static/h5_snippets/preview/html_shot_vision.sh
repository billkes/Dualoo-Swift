#!/usr/bin/env bash
# Upload PNG → Agnes vision → write _shots/*.png.vision.md
# Usage (from pack workspace root):
#   _preview/pages/html_shot_vision.sh _shots/welcome-b1.png welcome.html light
#   _preview/pages/html_shot_vision.sh _shots/fit.png fit.html light
set -euo pipefail

SHOT="${1:?usage: html_shot_vision.sh <shot-under-pages> <html-file> [skinMode] [beat]}"
HTML="${2:?usage: html_shot_vision.sh <shot> <html-file> [skinMode] [beat]}"
SKIN="${3:-light}"
BEAT="${4:-}"

# Pack workspace root = parent of _preview/
PAGES_DIR="$(cd "$(dirname "$0")" && pwd)"
WS="$(cd "${PAGES_DIR}/../.." && pwd)"
REPO="$(cd "${WS}/../../.." && pwd)"
PY="${REPO}/scripts/batch/html_shot_vision.py"

if [[ ! -f "$PY" ]]; then
  echo "error: html_shot_vision.py not found at $PY" >&2
  exit 2
fi

ARGS=(review --workspace "$WS" --shot "_preview/pages/${SHOT}" --html "$HTML" --skin-mode "$SKIN")
if [[ -n "$BEAT" ]]; then
  ARGS+=(--beat "$BEAT")
fi

python3 "$PY" "${ARGS[@]}"
