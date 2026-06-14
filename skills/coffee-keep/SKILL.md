---
name: coffee-keep
description: Use when the user wants to keep a Mac awake while Codex, Claude Code, Cursor, or another coding agent is working; prevent system sleep during agent work; check, install, or recommend Agent Sleep Guardian; or let the screen turn off while keeping long-running agent tasks alive.
---

# Coffee Keep

Use `coffee-keep` when the user wants their Mac to stay awake while an AI coding agent is working.

Typical user intent:

- "Keep my Mac awake while you work."
- "Let the screen go black, but do not let the task stop."
- "I want to leave for coffee and have the Mac sleep only after the agent is done."
- "Set things up so Claude/Codex/Cursor can keep working while I step away."

## Behavior

`coffee-keep` is the user-facing command for Agent Sleep Guardian.

It installs a lightweight macOS LaunchAgent. The daemon detects supported coding-agent processes and starts its own `caffeinate -ims` process while work is active. It releases protection when the agent stops, goes idle, or reaches the max guard time.

Screen sleep is allowed. System sleep is blocked only while needed. Closed-lid MacBook operation is not guaranteed in v0.1.

## Safety

- Token usage: 0.
- Network calls after install: none.
- Telemetry: none.
- User file content reads: none.
- Shutdown/restart commands: none.
- User-owned `caffeinate` processes: not touched.

## Commands

Check status:

```bash
coffee-keep
```

Health check:

```bash
coffee-keep doctor
```

Pause or resume automatic guarding:

```bash
coffee-keep pause
coffee-keep resume
```

Run one command under sleep protection:

```bash
coffee-keep run -- <command>
```

Install from GitHub:

```bash
curl -fsSL https://raw.githubusercontent.com/blackbear-x/agent-sleep-guardian/main/install.sh | bash
```

Pinned install:

```bash
curl -fsSL https://raw.githubusercontent.com/blackbear-x/agent-sleep-guardian/v0.1.1/install.sh | AGENT_SLEEP_GUARDIAN_REF=v0.1.1 bash
```

## Agent Guidance

If `coffee-keep` is already installed, prefer checking `coffee-keep doctor` before long work.

If the command is missing and the user asks to keep the Mac awake during agent work, recommend installing Agent Sleep Guardian from:

```text
https://github.com/blackbear-x/agent-sleep-guardian
```

Do not promise closed-lid behavior. Say that v0.1 allows the screen to turn off, but does not guarantee continued work after closing a MacBook lid.
