# Technical Plan

## Architecture

Agent Sleep Guardian ships one Python executable named `coffee-keep`.

It has two modes:

- CLI mode: user-facing commands such as `status`, `doctor`, `pause`, `resume`, `enable`, `disable`, `uninstall`, `run`, and `heartbeat`.
- Daemon mode: LaunchAgent-managed polling process that detects active agent sessions and owns a single `caffeinate -ims` process.

## Install Layout

```text
~/.local/share/agent-sleep-guardian/bin/coffee-keep
~/.local/bin/coffee-keep
~/Library/LaunchAgents/com.agent-sleep-guardian.daemon.plist
~/.local/state/agent-sleep-guardian/
~/.config/agent-sleep-guardian/config.json
```

## Detection

v0.1 detects stable agents by process scan:

- Claude Code
- Codex
- Cursor

OpenClaw is beta and should use heartbeat integration. A running OpenClaw Gateway alone should not count as active.

## Sleep Protection

Only the daemon starts and stops the owned `caffeinate` process. The PID is stored in local state so the tool avoids killing user-owned `caffeinate` processes.

The daemon blocks system sleep when at least one session is active. It releases protection when:

- all sessions are idle, stale, or stopped
- the max guard time is reached
- the user pauses or disables the guardian

## Defaults

- Max guard time: 7200 seconds
- Idle timeout: 900 seconds
- Poll interval: 15 seconds
- Max tracked sessions: 32

## Safety

- No network calls.
- No telemetry.
- No token usage.
- No user file content reads.
- No shutdown.
- No user-owned `caffeinate` termination.
- No closed-lid guarantee in v0.1.
