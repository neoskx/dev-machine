#!/bin/bash
# Bootstrap a new machine to a full development environment
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "============================================"
echo "  dev-machine: Setting up dev environment"
echo "============================================"
echo ""

# 1. Homebrew
if ! command -v brew &>/dev/null; then
  echo "==> Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "==> Homebrew already installed."
fi

# 2. Brewfile (apps, CLI tools, fonts)
echo "==> Installing packages from Brewfile..."
brew bundle --file="$SCRIPT_DIR/brew/Brewfile" --no-lock

# 3. macOS preferences
echo ""
bash "$SCRIPT_DIR/macos/defaults.sh"

# 4. Terminal (oh-my-zsh, plugins, starship)
echo ""
bash "$SCRIPT_DIR/terminal/setup.sh"

# 5. Languages (nvm, pyenv)
echo ""
bash "$SCRIPT_DIR/languages/setup.sh"

# 6. AI agent rules
echo ""
bash "$SCRIPT_DIR/ai/install.sh"

# 7. Dotfiles (if any exist)
if [ -f "$SCRIPT_DIR/dotfiles/install.sh" ]; then
  echo ""
  bash "$SCRIPT_DIR/dotfiles/install.sh"
fi

echo ""
echo "============================================"
echo "  Setup complete!"
echo "============================================"
echo ""
echo "Next steps:"
echo "  1. Restart your terminal"
echo "  2. Configure Cursor: Settings > General > Rules for AI"
echo "     Add: Always read and follow my personal rules from ~/.ai-rules/rules.md"
echo "  3. Set your preferred Node version: nvm install --lts"
echo "  4. Set your preferred Python version: pyenv install 3.x.x"
