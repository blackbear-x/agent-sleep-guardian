#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_DIR="${HOME}/.local/share/agent-sleep-guardian"
BIN_DIR="${HOME}/.local/bin"
COMMAND="${BIN_DIR}/coffee-keep"

mkdir -p "${INSTALL_DIR}/bin" "${BIN_DIR}"
cp "${ROOT_DIR}/bin/coffee-keep" "${INSTALL_DIR}/bin/coffee-keep"
chmod +x "${INSTALL_DIR}/bin/coffee-keep"
ln -sf "${INSTALL_DIR}/bin/coffee-keep" "${COMMAND}"

"${COMMAND}" enable >/dev/null

cat <<EOF
Agent Sleep Guardian installed.

Auto guardian: enabled and running
Command: coffee-keep
LaunchAgent: com.agent-sleep-guardian.daemon

Max guard time: 2h
Idle timeout: 15m

Network: none
Telemetry: none
Token usage: 0

You do not need to start it manually.
Coffee Keep will guard your Mac automatically when Claude, Codex, or Cursor starts working.

Try:
  coffee-keep doctor
  coffee-keep status

If coffee-keep is not found, add this to your shell profile:
  export PATH="\$HOME/.local/bin:\$PATH"
EOF
