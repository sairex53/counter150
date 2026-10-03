# Counter150

A tiny macOS menu-bar counter. Click the displayed `x/150` value to increment it; the count survives restarts.

## Features

- Left-click to add one.
- Right-click or Control-click for reset and quit.
- Local persistence with UserDefaults.
- Optional launch agent starts the app at login and restarts it if it exits.
- No Dock icon or network service.

## Requirements

Apple Silicon Mac, macOS 26 or later, and Xcode Command Line Tools with a macOS 26 SDK. The build script currently targets `arm64`.

## Build

```sh
./scripts/build.sh
open .build/Counter150.app
```

## Install with login startup

```sh
./scripts/install.sh
```

Installs the app in `~/Applications/Counter150.app` and the launch agent in `~/Library/LaunchAgents/`. With the launch agent enabled, quitting the app causes it to restart.

To remove the installed app and login agent:

```sh
./scripts/uninstall.sh
```

## Structure

- `Sources/main.swift`: AppKit menu-bar app and counter state.
- `Resources/`: application metadata and launch-agent template.
- `scripts/`: build, installation and removal commands.

Builds are signed locally with an ad-hoc signature. They are not notarized releases. The public bundle identifier is `org.counter150.app`.

## License

[MIT](LICENSE) © 2026 sairex53.
