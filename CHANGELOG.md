# Changelog

## Unreleased

- Add bilingual usage scenario copy explaining when to use `coffee-keep`.
- Add a Codex skill definition for agent-aware recommendations.

## v0.1.1

- Add `coffee-keep --version` and `coffee-keep version`.
- Make default status output easier to read by summarizing each agent as active or stale.
- Add a Chinese README.
- Document pinned install commands.
- Make the installer print the files and LaunchAgent it will create before making changes.
- Fix remote `curl | bash` installs by downloading `bin/coffee-keep` when the repo checkout is not present.
- Add a minimal GitHub Actions check.

## v0.1.0

Initial public beta.

- Add `coffee-keep`, a macOS command for keeping the system awake while coding agents are active.
- Add automatic LaunchAgent startup after install.
- Detect Claude Code, Codex, and Cursor by local process scan.
- Add OpenClaw beta support through heartbeat commands.
- Add `status`, `doctor`, `pause`, `resume`, `enable`, `disable`, `run`, and `uninstall`.
- Use an owned `caffeinate -ims` process and avoid touching user-owned `caffeinate` processes.
- Document safety limits: no tokens, no network calls, no telemetry, no file-content reads, and no closed-lid guarantee.
