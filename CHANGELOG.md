# Changelog

## v0.1.0

Initial public beta.

- Add `coffee-keep`, a macOS command for keeping the system awake while coding agents are active.
- Add automatic LaunchAgent startup after install.
- Detect Claude Code, Codex, and Cursor by local process scan.
- Add OpenClaw beta support through heartbeat commands.
- Add `status`, `doctor`, `pause`, `resume`, `enable`, `disable`, `run`, and `uninstall`.
- Use an owned `caffeinate -ims` process and avoid touching user-owned `caffeinate` processes.
- Document safety limits: no tokens, no network calls, no telemetry, no file-content reads, and no closed-lid guarantee.
