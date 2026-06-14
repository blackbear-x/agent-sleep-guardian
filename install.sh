#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_DIR="${HOME}/.local/share/agent-sleep-guardian"
BIN_DIR="${HOME}/.local/bin"
COMMAND="${BIN_DIR}/coffee-keep"
REPO_RAW_URL="https://raw.githubusercontent.com/blackbear-x/agent-sleep-guardian"
REF="${AGENT_SLEEP_GUARDIAN_REF:-main}"

echo "Agent Sleep Guardian installer"
echo
echo "Will install:"
echo "  command: ${COMMAND}"
echo "  app dir: ${INSTALL_DIR}"
echo "  LaunchAgent: ${HOME}/Library/LaunchAgents/com.agent-sleep-guardian.daemon.plist"
echo "  state: ${HOME}/.local/state/agent-sleep-guardian"
echo "  config: ${HOME}/.config/agent-sleep-guardian/config.json"
echo
echo "Safety:"
echo "  network after install: none"
echo "  telemetry: none"
echo "  token usage: 0"
echo "  file-content reads: none"
echo

mkdir -p "${INSTALL_DIR}/bin" "${BIN_DIR}"

if [[ -f "${ROOT_DIR}/bin/coffee-keep" ]]; then
  cp "${ROOT_DIR}/bin/coffee-keep" "${INSTALL_DIR}/bin/coffee-keep"
else
  if ! command -v curl >/dev/null 2>&1; then
    echo "curl is required for remote install." >&2
    exit 1
  fi
  echo "Downloading coffee-keep from ${REPO_RAW_URL}/${REF}/bin/coffee-keep"
  curl -fsSL "${REPO_RAW_URL}/${REF}/bin/coffee-keep" -o "${INSTALL_DIR}/bin/coffee-keep"
fi

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
