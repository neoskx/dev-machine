# Personal AI Agent Rules — Neo

These are my personal defaults. They apply to ALL projects as a baseline.

**Priority**: Project-specific rules (`.cursor/rules/`, `.ai/rules/`, `CLAUDE.md`, `AI-AGENTS.md`) always take precedence over these personal rules. If a project rule conflicts with a rule here, follow the project rule.

**Rule files**: This is the entry point. Other `.mdc` files in `~/.ai-rules/` are loaded automatically by the editor based on their frontmatter (`alwaysApply`, `globs`). Do NOT manually read all files — let the MDC system handle loading.

| File | Scope | Description |
|------|-------|-------------|
| `rules.md` | Always | This file — process, priorities, communication |
| `code-quality.mdc` | Always | Naming, functions, formatting, error handling, design principles |
| `testing.mdc` | Always | TDD workflow and testing standards |
| `security.mdc` | Always | Security best practices |
| `architecture.mdc` | Always | Architecture, API design, SOLID, observability |
| `git.mdc` | Always | Git workflow, commits, code review |
| `planning.mdc` | Always | Evaluate whether task needs a plan, check for existing plans |
| `typescript.mdc` | `*.ts, *.tsx` | TypeScript strict patterns |
| `accessibility.mdc` | `*.jsx, *.tsx, *.html` | Accessibility (a11y) standards |
| `performance.mdc` | `*.js, *.jsx, *.ts, *.tsx` | Web performance, Core Web Vitals, loading strategy |
| `planning-templates.mdc` | On demand | Full plan/log templates — loaded when creating a new plan |
| `CHANGELOG.md` | On demand | Rule change history — read during retrospectives |

---

## Process

1. **Project rules take priority.** If the project has `.ai/rules/`, `.cursor/rules/`, `CLAUDE.md`, or `AI-AGENTS.md`, those rules override anything here. Don't manually re-read them — the editor loads them automatically.
2. **Follow existing patterns.** Before creating anything, check how the codebase already does it. Match the conventions exactly.
3. **Ask before creating new files.** If unsure whether a new file is needed, ask. Prefer editing existing files.
4. **Don't over-engineer.** Solve the problem at hand. Don't add abstractions "for the future." Wait for the third concrete use case.
5. **Verify before declaring done.** Run tests, type-check, and lint after making changes. Don't deliver unverified code.
6. **Deliver incrementally.** For large tasks, commit at natural breakpoints. Show working progress rather than holding all changes until the end. This prevents context overflow and lets the user course-correct early.

---

## Communication

1. **Explain trade-offs.** When making a design decision, briefly explain what alternatives were considered and why this approach was chosen.
2. **Flag risks.** If a change has non-obvious side effects, security implications, or performance concerns, call them out proactively.
3. **Be honest about uncertainty.** If you're not sure about a pattern, API, or behavior, say so rather than guessing.
