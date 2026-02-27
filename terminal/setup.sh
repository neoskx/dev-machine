#!/bin/bash
# Terminal setup: oh-my-zsh, plugins, starship
set -euo pipefail

echo "==> Setting up terminal..."

# oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "  Installing oh-my-zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# Plugins
declare -A plugins=(
  ["zsh-syntax-highlighting"]="https://github.com/zsh-users/zsh-syntax-highlighting.git"
  ["zsh-autosuggestions"]="https://github.com/zsh-users/zsh-autosuggestions.git"
  ["zsh-completions"]="https://github.com/zsh-users/zsh-completions.git"
)

for plugin in "${!plugins[@]}"; do
  if [ ! -d "$ZSH_CUSTOM/plugins/$plugin" ]; then
    echo "  Installing $plugin..."
    git clone "${plugins[$plugin]}" "$ZSH_CUSTOM/plugins/$plugin"
  fi
done

# Starship prompt
if ! command -v starship &>/dev/null; then
  echo "  Starship not found. Install via: brew install starship"
fi

if [ ! -f "$HOME/.config/starship.toml" ]; then
  echo "  Configuring starship with nerd-font-symbols preset..."
  mkdir -p "$HOME/.config"
  starship preset nerd-font-symbols -o "$HOME/.config/starship.toml"
fi

echo "==> Terminal setup complete."
echo "    Add to .zshrc:"
echo '    plugins=(git colored-man-pages zsh-autosuggestions zsh-syntax-highlighting zsh-completions)'
echo '    eval "$(starship init zsh)"'
