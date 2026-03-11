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
| `planning.mdc`           | Always                    | Plan-first workflow — every task gets a plan, no exceptions      |
| `typescript.mdc`         | Always                    | TypeScript strict patterns                                       |
| `accessibility.mdc`      | Always (for JSX/TSX/HTML) | Accessibility (a11y) standards                                   |
| `performance.mdc`        | Always (for JS/TS work)   | Web performance, Core Web Vitals, loading strategy               |
| `planning-templates.mdc` | On demand                 | Templates for plan.md, changelog.md, chat.md, log-NN.md         |
| `skills/*.mdc`           | On demand                 | Reusable skills — read when the task matches the skill's domain  |
| `CHANGELOG.md`           | On demand                 | Rule change history — read during retrospectives                 |

---

## Process

### Phase 1: Agent Start

1. **Always read the rule files.** Conversation summaries are not a substitute. When a session starts with a prior summary, still read every "Always" file in the table above. Summaries may omit rules, contain stale context, or propagate errors from prior sessions.
2. **Project rules take priority.** If the project has `.ai/rules/`, `.cursor/rules/`, `CLAUDE.md`, or `AI-AGENTS.md`, those rules override anything here. Don't manually re-read them — the editor loads them automatically.
3. **Follow existing patterns.** Before creating anything, check how the codebase already does it. Match the conventions exactly.

### Phase 2: During Conversation

4. **Plan first.** Every task gets a plan. Create the task folder and `plan.md`, discuss with the user, and get confirmation before writing any code. See `planning.mdc` for the full workflow.
5. **Update task files incrementally.** At every decision point, update the relevant task files (plan.md, changelog.md, chat.md, log-NN.md) BEFORE moving on. Explicitly state which files you are updating and why. See the Checkpoint Rule in `planning.mdc`.
6. **Deliver incrementally.** Commit at natural breakpoints. Show working progress rather than holding all changes until the end. This prevents context overflow and lets the user course-correct early.
7. **Don't over-engineer.** Solve the problem at hand. Don't add abstractions "for the future." Wait for the third concrete use case.
8. **Ask before creating new files.** If unsure whether a new file is needed, ask. Prefer editing existing files.
9. **Flag rule conflicts.** If two rules contradict each other (between personal rule files, or between personal and project rules), flag the conflict to the user with both sides and ask which to follow. Don't silently pick one.

### Phase 3: Task Completion

10. **Ask the user if the task is done.** Don't assume a task is complete. Confirm with the user before closing it out.
11. **Verify before declaring done.** Run the pre-commit verification from `git.mdc` (formatter, linter, type-checker) one final time. Confirm all errors are resolved. For date-sensitive operations, verify the current date with `date`.
12. **Self-evolution.** Reflect on the rules: were any missing, wrong, redundant, or too strict? Propose specific improvements — rule changes, new skills, workflow refinements. The user decides whether to apply them. When approved, update the rule file(s), `CHANGELOG.md`, and `README.md` per the workflow in `planning.mdc`.

### Phase 4: Commit

13. **Finalize all task files first.** Update plan.md (mark completed), log.md (record final actions), chat.md (capture final exchange), and changelog.md to their final state BEFORE committing. Committed files must reflect the complete state — never commit then update.
14. **Ask before committing.** Show the user what will be committed and ask for confirmation. Never auto-commit without asking.
15. **Commit task files.** Commit the task folder (`$AI_AGENT_TASKS_FOLDER/{type}/{name}/`) to its git repo. Use conventional commit format.
16. **Commit rule changes.** If `~/.ai-rules/` was updated (self-evolution, rule fixes), commit those changes to the `~/.dev-machine` repo. Use conventional commit format.
17. **Commit project code.** If the task involved code changes in a project repo, commit those to the project repo. Follow the project's branching model and commit conventions.
18. **Push.** Push all committed repos to remote.

---

## Communication

1. **Explain trade-offs.** When making a design decision, briefly explain what alternatives were considered and why this approach was chosen.
2. **Flag risks.** If a change has non-obvious side effects, security implications, or performance concerns, call them out proactively.
3. **Be honest about uncertainty.** If you're not sure about a pattern, API, or behavior, say so rather than guessing.
