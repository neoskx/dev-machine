# Personal AI Agent Rules — Neo

These are my personal defaults. They apply to ALL projects as a baseline.

**Priority**: Project-specific rules (`.cursor/rules/`, `.ai/rules/`, `CLAUDE.md`, `AI-AGENTS.md`) always take precedence over these personal rules. If a project rule conflicts with a rule here, follow the project rule.

**Rule files**: This is the entry point. These files live in `~/.ai-rules/` which is **outside the workspace**, so Cursor's MDC system cannot auto-load them. You MUST manually read them using the Read tool.

**On every conversation start**, read ALL files marked "Always" below (batch the Read calls):

| File                     | When to read              | Description                                                      |
| ------------------------ | ------------------------- | ---------------------------------------------------------------- |
| `rules.md`               | Always                    | This file — process, priorities, communication                   |
| `code-quality.mdc`       | Always                    | Naming, functions, formatting, error handling, design principles |
| `testing.mdc`            | Always                    | TDD workflow and testing standards                               |
| `security.mdc`           | Always                    | Security best practices                                          |
| `architecture.mdc`       | Always                    | Architecture, API design, SOLID, observability                   |
| `git.mdc`                | Always                    | Git workflow, commits, code review                               |
| `planning.mdc`           | Always                    | Evaluate whether task needs a plan, check for existing plans     |
| `typescript.mdc`         | Always                    | TypeScript strict patterns                                       |
| `accessibility.mdc`      | Always (for JSX/TSX/HTML) | Accessibility (a11y) standards                                   |
| `performance.mdc`        | Always (for JS/TS work)   | Web performance, Core Web Vitals, loading strategy               |
| `planning-templates.mdc` | On demand                 | Full plan/log templates — loaded when creating a new plan        |
| `CHANGELOG.md`           | On demand                 | Rule change history — read during retrospectives                 |

---

## Process

1. **Project rules take priority.** If the project has `.ai/rules/`, `.cursor/rules/`, `CLAUDE.md`, or `AI-AGENTS.md`, those rules override anything here. Don't manually re-read them — the editor loads them automatically.
2. **Follow existing patterns.** Before creating anything, check how the codebase already does it. Match the conventions exactly.
3. **Ask before creating new files.** If unsure whether a new file is needed, ask. Prefer editing existing files.
4. **Don't over-engineer.** Solve the problem at hand. Don't add abstractions "for the future." Wait for the third concrete use case.
5. **Verify before declaring done.** After making changes, run the project's formatter, linter, and type-checker (e.g., `npm run format:fix`, `npm run lint:fix`, `npm run type-check`). Fix any errors before committing — zero lint warnings/errors is the bar. Check the project rules or `package.json` for the exact commands. For date-sensitive operations (changelogs, commits, timestamps), verify the current date with `date` — the system prompt date is a snapshot from conversation start and goes stale in long sessions.
6. **Deliver incrementally.** For large tasks, commit at natural breakpoints. Show working progress rather than holding all changes until the end. This prevents context overflow and lets the user course-correct early.
7. **Flag rule conflicts.** If two rules contradict each other (between personal rule files, or between personal and project rules), flag the conflict to the user with both sides and ask which to follow. Don't silently pick one.
8. **Suggest rule improvements.** At the end of non-trivial tasks, briefly note if any rules were missing, unclear, conflicting, or overly strict. Propose specific edits (not vague feedback). The user decides whether to apply them. When approved, update the rule file(s), `CHANGELOG.md`, and `README.md` per the workflow in `planning.mdc`.

---

## Communication

1. **Explain trade-offs.** When making a design decision, briefly explain what alternatives were considered and why this approach was chosen.
2. **Flag risks.** If a change has non-obvious side effects, security implications, or performance concerns, call them out proactively.
3. **Be honest about uncertainty.** If you're not sure about a pattern, API, or behavior, say so rather than guessing.
