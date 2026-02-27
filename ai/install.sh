#!/bin/bash
# Symlink ai/ directory to ~/.ai-rules so Cursor and other agents can find it
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ -L "$HOME/.ai-rules" ]; then
  echo "~/.ai-rules symlink already exists, updating..."
  rm "$HOME/.ai-rules"
elif [ -d "$HOME/.ai-rules" ]; then
  echo "~/.ai-rules is a directory. Backing up to ~/.ai-rules.bak..."
  mv "$HOME/.ai-rules" "$HOME/.ai-rules.bak"
fi

ln -sfn "$SCRIPT_DIR" "$HOME/.ai-rules"
echo "~/.ai-rules -> $SCRIPT_DIR"
echo ""
echo "Configure Cursor: Settings > General > Rules for AI:"
echo '  Always read and follow my personal rules from ~/.ai-rules/rules.md before starting any task.'
