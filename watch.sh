#!/bin/sh

WATCH_PATHS="${WATCH_PATHS:-/site/layouts /site/themes}"
TOUCH_FILE="${TOUCH_FILE:-/site/content/_index.md}"
TMP_FILE="${TMP_FILE:-/tmp/.hugo-watcher-reload.md}"
RELOAD_DELAY_MS="${RELOAD_DELAY_MS:-200}"

echo "👀 Watching paths: $WATCH_PATHS"
echo "📝 Touch file: $TOUCH_FILE"
echo "📦 Temp file: $TMP_FILE"
echo "⏱️ Delay before reload: ${RELOAD_DELAY_MS}ms"

inotifywait -m -r -e modify,close_write,move,create,delete $WATCH_PATHS |
while read path action file; do
  echo "🔄 Change detected: $path$file ($action)"
  sleep $(awk "BEGIN {print $RELOAD_DELAY_MS / 1000}")
  cp "$TOUCH_FILE" "$TMP_FILE" && mv "$TMP_FILE" "$TOUCH_FILE"
done
