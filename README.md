# dev-machine

Set up a full development environment on a new Mac in minutes.

## Quick Start

```bash
git clone https://github.com/neoskx/dev-machine.git ~/.dev-machine
cd ~/.dev-machine
./setup.sh
```

## What It Does

| Step | What | Script |
|------|-------|--------|
| 1 | Install Homebrew + all apps/tools | `brew/Brewfile` |
| 2 | Configure macOS Finder preferences | `macos/defaults.sh` |
| 3 | Set up oh-my-zsh, plugins, starship | `terminal/setup.sh` |
| 4 | Install nvm, pyenv | `languages/setup.sh` |
| 5 | Link AI agent rules to `~/.ai-rules` | `ai/install.sh` |

## Structure

```
dev-machine/
├── setup.sh               # One-command bootstrap
├── macos/
│   └── defaults.sh        # macOS system preferences
├── brew/
│   └── Brewfile           # Homebrew packages, casks, fonts
├── terminal/
│   └── setup.sh           # oh-my-zsh, plugins, starship
├── languages/
│   └── setup.sh           # nvm, pyenv
├── dotfiles/              # Shell configs (add .zshrc, .gitconfig, etc.)
└── ai/
    ├── rules.md           # Personal AI agent rules
    ├── skills/            # Reusable AI workflows
    └── install.sh         # Symlinks ai/ to ~/.ai-rules
```

## AI Agent Rules

Personal rules in `ai/rules.md` are loaded by AI agents (Cursor, Claude, etc.) via the `~/.ai-rules` symlink.

**Cursor setup**: Settings > General > Rules for AI:

```
Always read and follow my personal rules from ~/.ai-rules/rules.md before starting any task.
```

**Claude Code setup**:

```bash
echo "Always read and follow my personal rules from ~/.ai-rules/rules.md" > ~/.claude/CLAUDE.md
```

These rules work alongside project-specific rules (`.cursor/rules/`, `.ai/rules/`, `CLAUDE.md` in each repo).

## Apps Installed (via Brewfile)

**CLI**: mkcert, nss, starship, pyenv

**Apps**: iTerm2, VS Code, Cursor, Docker

**Fonts**: Hack Nerd Font

Edit `brew/Brewfile` to customize.

## Run Individual Steps

```bash
./macos/defaults.sh        # Only macOS preferences
./terminal/setup.sh        # Only terminal setup
./languages/setup.sh       # Only language runtimes
./ai/install.sh            # Only AI rules symlink
brew bundle --file=brew/Brewfile  # Only Homebrew packages
```
