#!/bin/zsh
set -euo pipefail

APP_NAME="Counter150"
APP_DEST="$HOME/Applications/$APP_NAME.app"
PLIST_PATH="$HOME/Library/LaunchAgents/org.counter150.app.plist"
DOMAIN="gui/$(id -u)"

if launchctl print "$DOMAIN/org.counter150.app" >/dev/null 2>&1; then
    launchctl bootout "$DOMAIN/org.counter150.app" >/dev/null 2>&1 || true
fi
rm -f "$PLIST_PATH"
rm -rf "$APP_DEST"

echo "Counter150 removed"
