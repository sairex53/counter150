#!/bin/zsh
set -euo pipefail

ROOT_DIR="${0:A:h:h}"
APP_NAME="Counter150"
APP_SOURCE="$ROOT_DIR/.build/$APP_NAME.app"
APP_DEST="$HOME/Applications/$APP_NAME.app"
AGENTS_DIR="$HOME/Library/LaunchAgents"
PLIST_PATH="$AGENTS_DIR/org.counter150.app.plist"
DOMAIN="gui/$(id -u)"

"$ROOT_DIR/scripts/build.sh"
mkdir -p "$HOME/Applications" "$AGENTS_DIR"
rm -rf "$APP_DEST"
cp -R "$APP_SOURCE" "$APP_DEST"

if launchctl print "$DOMAIN/org.counter150.app" >/dev/null 2>&1; then
    launchctl bootout "$DOMAIN/org.counter150.app" >/dev/null 2>&1 || true
fi

sed "s|__APP_EXECUTABLE__|$APP_DEST/Contents/MacOS/$APP_NAME|" \
    "$ROOT_DIR/Resources/org.counter150.app.plist" > "$PLIST_PATH"
launchctl bootstrap "$DOMAIN" "$PLIST_PATH"
launchctl enable "$DOMAIN/org.counter150.app"

echo "Installed $APP_DEST"
echo "Autostart enabled through $PLIST_PATH"
