#!/bin/zsh
set -euo pipefail

ROOT_DIR="${0:A:h:h}"
APP_NAME="Counter150"
BUILD_DIR="$ROOT_DIR/.build"
APP_DIR="$BUILD_DIR/$APP_NAME.app"
SDK_PATH="$(xcrun --sdk macosx --show-sdk-path)"

rm -rf "$APP_DIR"
mkdir -p "$APP_DIR/Contents/MacOS" "$APP_DIR/Contents/Resources"

swiftc \
    -sdk "$SDK_PATH" \
    -target arm64-apple-macosx26.0 \
    -O \
    -framework AppKit \
    "$ROOT_DIR/Sources/main.swift" \
    -o "$APP_DIR/Contents/MacOS/$APP_NAME"

cp "$ROOT_DIR/Resources/Info.plist" "$APP_DIR/Contents/Info.plist"
codesign --force --deep --sign - "$APP_DIR" >/dev/null

echo "Built $APP_DIR"
