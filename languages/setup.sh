#!/bin/bash
# Development language runtimes
set -euo pipefail

echo "==> Setting up development languages..."

# Node.js via nvm
if [ ! -d "$HOME/.nvm" ]; then
  echo "  Installing nvm..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
fi

# Python via pyenv (installed via Brewfile)
if command -v pyenv &>/dev/null; then
  echo "  pyenv is installed."
  echo "  Add to .zshrc:"
  echo '    export PYENV_ROOT="$HOME/.pyenv"'
  echo '    [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"'
  echo '    eval "$(pyenv init -)"'
else
  echo "  pyenv not found. Install via: brew install pyenv"
fi

echo "==> Language setup complete."
