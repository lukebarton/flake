Sync macOS app defaults into `configs/misc-app-defaults.nix`.

The user will provide an app name, bundle ID, or description: "$ARGUMENTS"

If a bundle ID wasn't provided directly, find it by searching:
- `mdfind "kMDItemCFBundleIdentifier == '*<name>*'"` or
- `osascript -e 'id of app "<name>"'`

Once you have the bundle ID, read the live defaults with `defaults read <bundle-id>`.

Then sync into `configs/misc-app-defaults.nix`:

## Filtering rules — exclude values that won't survive across installations:
- Window frames/positions (NSWindow Frame, windowOriginX/Y, windowWidth/Height)
- Binary blobs (length = ..., bytes = ...)
- Migration/run-once flags (runOnce, hasMigrated, everVisited, etc.)
- Launch counts, dates, timestamps (launchCount, installDate, firstLaunchDate, etc.)
- UUIDs, device-specific IDs (uid, sid, screenID, calendar UUIDs, etc.)
- Sparkle update state (SU*)
- UI state (selectedTabIndex, NSSplitView, NSToolbar, NSStatusItem)
- Credentials, tokens, license keys, vaults
- Telemetry event logs (GATelemetry, localEventCounter, etc.)
- Version/update tracking (latestBuild, latestVersionCode, activeAppVersion, previousLaunchedVersion)

## Formatting rules:
- Use `true`/`false` for 0/1 booleans, strings for string values, integers/floats for numbers
- Keep keys alphabetically sorted
- New settings must be commented out with `#` flush against the property name, e.g. `#myKey = "value";`
- When updating an existing section, preserve the commented/uncommented state of existing lines and only add genuinely new settings (commented out)
- If the app doesn't have a section yet, add a new one with a comment header and all settings commented out
