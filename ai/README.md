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
Before starting any task, read ~/.ai-rules/rules.md using the Read tool. Other .mdc files in that directory load automatically via MDC frontmatter — do not manually read them. Project-specific rules (.cursor/rules/, .ai/rules/, CLAUDE.md, AI-AGENTS.md) always take priority over personal rules when they conflict.
```

**Claude Code**: Add to `~/.claude/CLAUDE.md`:
```
Read and follow rules from ~/.ai-rules/rules.md and all .mdc files in that directory.
```

## File Structure

```
~/.ai-rules/
├── README.md              # This file
├── CHANGELOG.md           # Rule change history — read during retrospectives
├── rules.md               # Entry point — process, priorities, general rules
├── code-quality.mdc       # Naming, functions, formatting, error handling, design principles
├── testing.mdc            # TDD workflow and testing standards
├── security.mdc           # Security best practices
├── typescript.mdc         # TypeScript strict patterns (scoped to .ts/.tsx)
├── architecture.mdc       # Architecture, API design, SOLID
├── git.mdc                # Git workflow, commits, code review
├── planning.mdc           # Lightweight trigger — evaluate if task needs a plan
├── planning-templates.mdc # Full plan/log templates (loaded on demand)
├── accessibility.mdc      # Accessibility (a11y) standards (scoped to .jsx/.tsx/.html)
├── performance.mdc        # Web performance, Core Web Vitals (scoped to .js/.jsx/.ts/.tsx)
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

### Loading Budget

| Category | Lines | When loaded |
|---|---|---|
| Always loaded | ~473 | Every conversation |
| Conditionally loaded | ~383 | Only when matching files are in context |

Always-loaded: `rules.md`, `code-quality.mdc`, `testing.mdc`, `security.mdc`, `architecture.mdc`, `git.mdc`, `planning.mdc`

Conditional: `typescript.mdc` (*.ts/*.tsx), `accessibility.mdc` (*.jsx/*.tsx/*.html), `performance.mdc` (*.js/*.jsx/*.ts/*.tsx), `planning-templates.mdc` (on demand)

### Self-Improving Feedback Loop

The rules evolve through a built-in retrospective cycle:

```
work → reflect → propose changes → user approves → update rules + CHANGELOG + README → work better
```

At the end of every planned task, the agent:
1. Reflects on whether any rules were missing, wrong, or redundant
2. Reads `CHANGELOG.md` to avoid re-suggesting previously reverted rules
3. Proposes changes to the user
4. On approval: updates the rule files, `CHANGELOG.md`, `README.md`, and `rules.md` file table

## Design Principles

1. **Actionable, not aspirational.** Every rule is something the AI can enforce right now, not a vague principle to "keep in mind."
2. **Concise.** Principal engineers don't need explanations of what SOLID means. Rules are stated once, clearly.
3. **Organized by concern.** Each file covers one domain. Easy to find, easy to override per-project.
4. **Escape hatches.** Rules can be skipped when the user explicitly says so. Pragmatism over dogma.
5. **Self-improving.** Rules evolve through retrospectives. Every change is tracked in `CHANGELOG.md`.

## Adding or Changing Rules

1. Pick the right file (or create a new `.mdc` if it's a new domain)
2. Set appropriate frontmatter (`alwaysApply`, `globs`, `description`)
3. Update the file table in `rules.md`
4. Update this `README.md` file structure and loading budget
5. Add an entry to `CHANGELOG.md` with what changed and why
6. Keep rules actionable and concise — if it needs a paragraph of explanation, it's too complex

## Customizing for a Project

Project rules live in the project repo, not here. Create:
- `.cursor/rules/` for Cursor-specific rules
- `.ai/rules/` for agent-agnostic rules
- `CLAUDE.md` for Claude Code

These automatically override personal rules when they conflict.
