#!/bin/bash
# macOS system preferences
set -euo pipefail

echo "==> Configuring macOS system preferences..."

# Finder: show library folder
chflags nohidden ~/Library

# Finder: show hidden files
defaults write com.apple.finder AppleShowAllFiles YES

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show items as column view
defaults write com.apple.finder FXPreferredViewStyle clmv

killall Finder

echo "==> macOS preferences configured."
