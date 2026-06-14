# Agent Sleep Guardian

Screen off is okay. Sleep is not.

Agent Sleep Guardian keeps your Mac awake while Claude Code, Codex, Cursor, or other coding agents are working. When they stop, stall, or time out, it releases sleep protection so your Mac can return to normal sleep behavior.

The project name is **Agent Sleep Guardian**. The command users type is **`coffee-keep`**.

## What Happens After Install

`coffee-keep` installs a small macOS LaunchAgent. You do not need to start it by hand.

The background guardian watches for supported coding-agent processes. When an agent is active, it starts its own `caffeinate -ims` process so macOS does not sleep. When the agent stops, goes idle, or reaches the max guard time, it releases that protection.

It allows the screen to turn off. It only protects system sleep.

## Safety

- Token usage: 0.
- Network calls: none.
- Telemetry: none.
- User file content reads: none.
- Shutdown/restart commands: none.
- User-owned `caffeinate` processes: not touched.
- Closed MacBook lid: not guaranteed in v0.1.

Files installed:

```text
~/.local/share/agent-sleep-guardian/bin/coffee-keep
~/.local/bin/coffee-keep
~/Library/LaunchAgents/com.agent-sleep-guardian.daemon.plist
~/.local/state/agent-sleep-guardian/
~/.config/agent-sleep-guardian/config.json
```

## v0.1 Scope

- macOS first.
- Uses macOS `caffeinate`.
- Installs a lightweight LaunchAgent.
- Starts automatically after install.
- Does not use tokens.
- Does not connect to the network.
- Does not upload telemetry.
- Does not read user file contents.
- Does not shut down the computer.
- Does not kill user-owned `caffeinate` processes.

## Install

Quick install:

```bash
curl -fsSL https://raw.githubusercontent.com/blackbear-x/agent-sleep-guardian/main/install.sh | bash
```

Manual install:

```bash
git clone https://github.com/blackbear-x/agent-sleep-guardian.git
cd agent-sleep-guardian
./install.sh
```

If you do not like piping a script into `bash`, use the manual install path so you can read `install.sh` first.

Install output:

```text
Agent Sleep Guardian installed.

Auto guardian: enabled and running
Command: coffee-keep
LaunchAgent: com.agent-sleep-guardian.daemon

You do not need to start it manually.
Coffee Keep will guard your Mac automatically when Claude, Codex, or Cursor starts working.
```

## Check Before Leaving

```bash
coffee-keep doctor
```

Example:

```text
Agent Sleep Guardian Doctor

macOS caffeinate: ok
Background guardian: running
LaunchAgent: enabled
Power: plugged in, 86%

Supported agents:
  Claude Code: stable
  Codex: stable
  Cursor: stable
  OpenClaw: beta, heartbeat recommended

Max guard time: 2h
Idle timeout: 15m
Token usage: 0
Network: none
Telemetry: none

Screen may turn off. System can stay awake.
Lid closed: not guaranteed in v0.1.
Ready: yes
```

## Status

```bash
coffee-keep status
```

Example:

```text
Mac sleep: blocked
Screen sleep: allowed
Power: plugged in, 82%

Agents: 3 detected, 2 active, 1 stale

- Claude Code: active, last activity 1m ago
- Codex: active, last activity 4m ago
- Cursor: stale, last activity 18m ago

Max guard time: 2h
Idle timeout: 15m

Screen off is okay. Sleep is not.
Lid closed: not guaranteed in v0.1.
```

## Commands

```bash
coffee-keep status
coffee-keep status --verbose
coffee-keep doctor
coffee-keep pause
coffee-keep resume
coffee-keep disable
coffee-keep enable
coffee-keep uninstall
```

Run one command under sleep protection:

```bash
coffee-keep run -- npm run render
```

OpenClaw beta heartbeat:

```bash
coffee-keep heartbeat --agent OpenClaw --status active
coffee-keep heartbeat --agent OpenClaw --status idle
```

## Defaults

- Max guard time: 2 hours
- Idle timeout: 15 minutes
- Max sessions tracked: 32
- Poll interval: 15 seconds

## OpenClaw

OpenClaw support is beta in v0.1.

Agent Sleep Guardian does not treat the OpenClaw Gateway daemon itself as active because it may be always-on. Use heartbeat or hooks to mark actual OpenClaw agent sessions as active.

## Lid Closed

v0.1 does not promise that a closed MacBook lid will keep running. For long agent jobs, keep the Mac plugged in and do not close the lid.

## Uninstall

```bash
coffee-keep uninstall
```

This unloads the LaunchAgent, stops the guardian's own `caffeinate` process, and removes the installed command and local state.
