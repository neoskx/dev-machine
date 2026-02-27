# ~/.ai-rules — Personal AI Agent Rules

Personal coding standards for AI agents (Cursor, Claude, GitHub Copilot, etc.). These rules apply to ALL projects as a baseline. Project-specific rules always take priority.

## Setup

```bash
# Symlink this directory to ~/.ai-rules
./install.sh
```

Then configure your AI agent to read these rules:

**Cursor IDE**: Settings > General > Rules for AI:
```
Before starting any task, read ~/.ai-rules/rules.md using the Read tool, then read all other .md and .mdc files listed in it. Project-specific rules (.cursor/rules/, .ai/rules/, CLAUDE.md, AI-AGENTS.md) always take priority over personal rules when they conflict.
```

**Claude Code**: Add to `~/.claude/CLAUDE.md`:
```
Read and follow rules from ~/.ai-rules/rules.md and all .mdc files in that directory.
```

## File Structure

```
~/.ai-rules/
├── README.md              # This file
├── rules.md               # Entry point — process, priorities, general rules
├── code-quality.mdc       # Naming, functions, formatting, error handling, design principles
├── testing.mdc            # TDD workflow and testing standards
├── security.mdc           # Security best practices
├── typescript.mdc         # TypeScript strict patterns (scoped to .ts/.tsx)
├── architecture.mdc       # Architecture, API design, SOLID
├── git.mdc                # Git workflow, commits, code review
├── planning.mdc           # Planning workflow for complex tasks
├── accessibility.mdc      # Accessibility (a11y) standards (scoped to .jsx/.tsx/.html)
├── performance.mdc        # Web performance, Core Web Vitals (scoped to .js/.jsx/.ts/.tsx)
├── skills/                # Specialized workflows (future)
└── install.sh             # Symlink setup script
```

## How It Works

### Priority System

```
Project rules  >  Personal rules (.ai-rules)
```

Every rule file states that project-specific rules take precedence. This means:
- If a project says "use `makeStyles`", that overrides the code-quality rule about styling
- If a project has its own commit convention, that overrides `git.mdc`
- If a project says "skip TDD for X", that overrides `testing.mdc`

### File Format

- **`.md` files** are always read (entry points, documentation)
- **`.mdc` files** use Cursor's MDC format with frontmatter metadata:
  - `alwaysApply: true` — loaded for every conversation
  - `alwaysApply: false` + `globs` — loaded only when matching files are in context
  - `description` — helps the agent decide when the rule is relevant

### Scoping

Most rules are `alwaysApply: true` because they're universal (security, architecture, git). Language-specific rules like `typescript.mdc` are scoped with globs so they only activate when you're working on TypeScript files.

## Design Principles

1. **Actionable, not aspirational.** Every rule is something the AI can enforce right now, not a vague principle to "keep in mind."
2. **Concise.** Principal engineers don't need explanations of what SOLID means. Rules are stated once, clearly.
3. **Organized by concern.** Each file covers one domain. Easy to find, easy to override per-project.
4. **Escape hatches.** Rules can be skipped when the user explicitly says so. Pragmatism over dogma.

## Adding New Rules

1. Pick the right file (or create a new `.mdc` if it's a new domain)
2. Set appropriate frontmatter (`alwaysApply`, `globs`, `description`)
3. Update the file table in `rules.md`
4. Keep rules actionable and concise — if it needs a paragraph of explanation, it's too complex

## Customizing for a Project

Project rules live in the project repo, not here. Create:
- `.cursor/rules/` for Cursor-specific rules
- `.ai/rules/` for agent-agnostic rules
- `CLAUDE.md` for Claude Code

These automatically override personal rules when they conflict.
