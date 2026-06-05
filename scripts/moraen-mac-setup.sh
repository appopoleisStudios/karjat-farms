#!/bin/bash
# GroundWork — Mac Mini one-time SSH setup
# Run on arsalans-mac-mini after placing the private key.
set -euo pipefail

KEY="$HOME/.ssh/cursor_macmini_moraen_cto"
HOST="100.99.243.39"
REPO="/home/moraen/projects/karjat-farms"

echo "=== GroundWork Mac Mini SSH Setup ==="

mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"

if [[ ! -f "$KEY" ]]; then
  echo "ERROR: Private key not found at $KEY"
  echo "Copy cursor_macmini_moraen_cto from moraen-Home first:"
  echo "  chmod 600 ~/.ssh/cursor_macmini_moraen_cto"
  exit 1
fi

chmod 600 "$KEY"

# Add SSH config entry if not present
if ! grep -q "Host groundwork-linux" "$HOME/.ssh/config" 2>/dev/null; then
  cat >> "$HOME/.ssh/config" <<'EOF'
Host groundwork-linux
  HostName 100.99.243.39
  User moraen
  IdentityFile ~/.ssh/cursor_macmini_moraen_cto
EOF
  chmod 600 "$HOME/.ssh/config"
  echo "Added groundwork-linux to ~/.ssh/config"
else
  echo "groundwork-linux already in ~/.ssh/config"
fi

# Trust moraen-Home host key
ssh-keyscan -H "$HOST" >> "$HOME/.ssh/known_hosts" 2>/dev/null

echo "Testing connection..."
ssh -o BatchMode=yes groundwork-linux "echo Connected && hostname && ls $REPO"

echo ""
echo "=== Success ==="
echo "Open Cursor → Remote SSH → groundwork-linux → $REPO"
echo "Read docs/HANDOFF-MORAEN.md for your Phase 0 tasks."
