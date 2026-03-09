# Rules Changelog

Track the evolution of `~/.ai-rules/`. Every rule change — create, update, delete — gets an entry here. This history supports troubleshooting, retrospectives, and prevents re-introducing previously reverted rules.

Format: reverse chronological. Each entry includes what changed, why, and what triggered it.

---

## 2026-03-09 (git attribution rule)

### Added

- **`git.mdc`** — New "Attribution" section: all commits and PRs must appear as the user's own work. Never include AI tool names in commit messages, PR titles, PR descriptions, or branch names. Never modify `user.name` or `user.email`.

### Rationale

During CRK-5618, user explicitly requested that no commits or PRs show any AI tool attribution. This was already the implicit behavior (git config is the user's identity), but codifying it as a rule ensures it's never violated in future sessions.

---

## 2026-03-08 (checkpoint rule restructured into execute loop)

### Changed

- **`planning.mdc`** — Restructured step 4 (EXECUTE) from a list of files to update into an explicit Do → Checkpoint → Communicate → Repeat loop. Merged the standalone "Incremental File Updates (Checkpoint Rule)" section into step 4 so the checkpoint is part of the action sequence, not a separate section to remember. Added TodoWrite forcing function: create a standing reminder when an active task exists. Added anti-patterns section warning against batch updates, "I'll remember later," and following batch-update patterns from conversation summaries.

### Rationale

During CRK-5629, the agent read and understood the checkpoint rule but violated it 3 times in one session. Root cause: the rule was a separate section read at session start but not active during execution. The immediate task crowded out the process rule. A prior session's conversation summary showed batch updates, and the agent mimicked that pattern despite the rule saying otherwise. Fix: embed the checkpoint directly into the execute loop so it's encountered at every action, not just at session start. Add TodoWrite as a visible in-session reminder.

---

## 2026-03-08 (git branching alignment + retrospective)

### Changed

- **`git.mdc`** — Updated Branching section to match task folder naming convention. Replaced `feat/`, `fix/` shorthand with `feature/`, `bugfix/`, `adhoc/`. Added table with examples including `adhoc/test-`, `adhoc/doc-`, `adhoc/perf-`. Cross-referenced `planning.mdc`.

### Rationale

Branch names and task folder names should use the same convention — one pattern to learn, one pattern to follow. Previously `git.mdc` used `feat/` and `fix/` while task folders used `feature/` and `bugfix/`.

---

## 2026-03-08 (planning workflow overhaul)

### Changed

- **`planning.mdc`** — Complete rewrite. Changed from "evaluate whether task needs a plan" to "every task gets a plan, no exceptions." Enforced strict workflow sequence: Check → Plan → Discuss → Confirm → Execute → Log → Chat → Commit → Retrospect. Added `$AI_AGENT_TASKS_FOLDER` env var as mandatory (no hardcoded fallback). Added folder naming convention matching git branches (feature/, adhoc/, bugfix/). Added cross-reference support via `## Related Tasks`. Added "new agent bootstrap" guidance for resuming tasks and picking up related work.

- **`planning-templates.mdc`** — Complete rewrite. Replaced two-file structure (plan.md + log.md) with four-file structure: `plan.md` (current truth), `changelog.md` (plan evolution), `chat.md` (conversation log with key User/Agent exchanges + session IDs), `log-NN.md` (per-iteration execution logs). Added conversational chat.md format for team knowledge transfer. Added file creation order. Added guidelines for what goes in each file.

- **`rules.md`** — Updated file table descriptions for planning.mdc and planning-templates.mdc.

- **`README.md`** — Updated file structure descriptions to match new planning system.

### Rationale

After a week of using the rules system, several failure modes were identified:
1. Agent inconsistently followed planning — the "evaluate whether to plan" rule gave too much discretion, leading to skipped plans
2. Repo-based plan directories didn't support cross-repo tasks — switched to task-based with git branch naming
3. No conversation persistence — added chat.md with User/Agent exchange format for team knowledge transfer
4. Plans created after task completion instead of before — enforced plan-first-then-execute as a hard rule
5. Single log.md file grew unwieldy and was only written at the end — switched to per-iteration log-NN.md files
6. No way to track plan evolution — added changelog.md per task
7. Agent didn't check $AI_AGENT_TASKS_FOLDER env var — made it mandatory with no hardcoded fallback. Renamed from $AI_AGENT_PLANS_FOLDER to $AI_AGENT_TASKS_FOLDER (folder contains more than just plans)

Inspired by Claude Code's "Explore → Plan → Implement → Commit" workflow and the gperkins-cursor-chats conversation logging pattern.

---

## 2026-03-01 (conversation summary bypass fix)

### Changed

- **`rules.md`** — Added Process rule #0: "Always read the rule files. Conversation summaries are not a substitute." When a session starts with a prior summary, the agent must still read every "Always" file. Summaries may omit rules, contain stale context, or propagate errors from prior sessions.

### Rationale

During a crawler update task, the agent relied on a conversation summary that listed rules as "already loaded" but omitted `planning.mdc`. This caused the agent to skip planning entirely, jump straight into multi-file implementation, and produce overly complex changes that had to be reverted. The same root cause was behind the earlier TodoWrite-vs-plan-files issue — summaries create a false sense of "already done."

---

## 2026-03-01 (planning clarity — TodoWrite vs persistent plans)

### Changed

- **`planning.mdc`** — Added key rule clarifying that `TodoWrite` is session-scoped and does NOT replace persistent `plan.md`/`log.md` files. Discovered during CRK-5554 implementation: the agent used `TodoWrite` for task tracking but missed creating plan files, losing context for future sessions.

### Rationale

In a resumed conversation with summarized context, the "Pending Tasks" from `TodoWrite` gave the impression that planning was done. But `TodoWrite` data vanishes between sessions. The new rule makes the distinction explicit so agents always create persistent plan files for qualifying tasks.

---

## 2026-03-01 (audit pass 3 — consistency and conflict resolution)

### Changed

- **`accessibility.mdc`** — Updated frontmatter from `alwaysApply: false` to `alwaysApply: true` for consistency with other always-loaded files.
- **`performance.mdc`** — Updated frontmatter from `alwaysApply: false` to `alwaysApply: true` for consistency with other always-loaded files.
- **`architecture.mdc`** — Aligned enum wording in "Patterns to Avoid" with `typescript.mdc`. Changed "enums, union types, or constants" to "union types, `as const` objects, enums, or constants" to reflect preferred alternatives.
- **`testing.mdc`** — Added project-override cross-reference to Mocking section: "Follow project-specific mocking conventions when they exist (see Conventions below)." Resolves conflict where personal rule says "mock at network level" but projects may use module-level mocks.
- **`planning.mdc`** — Simplified plans directory resolution from a 4-step process with `echo $AI_AGENT_PLANS_FOLDER` to a one-liner: "`$AI_AGENT_PLANS_FOLDER` if set, otherwise `~/.ai-agent-plans/`."

### Changed (project files)

- **`CLAUDE.md`** (in creator-hub workspace) — Slimmed from 75-line duplicate of `AI-AGENTS.md` content to a 4-line redirect. Both files were being injected into every Cursor conversation via `always_applied_workspace_rules`, doubling context token usage.

- **`rules.md`** — Added date verification guidance to Process #5: "For date-sensitive operations, verify the current date with `date` — the system prompt date goes stale in long sessions." Discovered when changelog was written with Feb 27 date in a conversation that started Feb 27 but continued to Mar 1. Strengthened Process #5 to explicitly require running the project's formatter, linter, and type-checker before committing, with zero lint warnings/errors as the bar.
- **`code-quality.mdc`** — Added "Run the project formatter before committing" rule to Formatting section. Generated code must be verified with the project's format tool, not hand-formatted.

### Rationale

Follow-up audit after adding self-improvement rules (#7, #8) to `rules.md`. Focused on resolving remaining inconsistencies: frontmatter alignment, enum guidance across files, mocking rule conflict with project conventions, verbose planning instructions, duplicate project entry points wasting context tokens, stale date in long-running conversations, and ensuring generated code passes project formatting and lint checks.

---

## 2026-02-27 (audit pass 2)

### Changed

- **`rules.md`** — Fixed loading instructions: removed "read ALL files" directive that conflicted with MDC conditional loading. Added "Verify before declaring done" (run tests/lint/type-check). Added "Deliver incrementally" (commit at natural breakpoints). Removed redundant "read project rules" instruction — Cursor loads them automatically.
- **`testing.mdc`** — Relaxed TDD from "mandatory for every code change" to "default for logic changes." Added explicit "when to use" and "when to skip" lists. TDD still applies to business logic, hooks, API handlers, bug fixes. Skipped for styling, config, translations, prototyping, and refactoring with existing tests.
- **`git.mdc`** — Removed duplicate "never commit secrets" rule body. Now references `security.mdc` as the single source of truth for secrets handling.
- **`architecture.mdc`** — Clarified "validate at the boundary" to avoid overlap with `security.mdc` input validation rules. Now references security.mdc and focuses on the type-safety/schema parsing aspect.
- **`README.md`** — Updated loading budget to accurate numbers (~473 always, ~383 conditional). Updated Cursor setup instruction to match new loading approach. Removed empty `skills/` directory reference.

### Rationale

Tech director audit focused on AI agent efficiency and industry best practices. Key findings: contradictory loading instructions wasted context, TDD was too rigid for non-logic work, duplicate rules across files wasted tokens and risked inconsistency, no verification step existed.

---

## 2026-02-27 (initial buildout)

### Added

- **`accessibility.mdc`** — Semantic HTML, keyboard nav, ARIA, forms, color/contrast, a11y testing. Gap identified during tech director audit — no a11y rules existed.
- **`performance.mdc`** — Core Web Vitals, loading strategy, images, rendering, data/network, bundle size, measurement. Gap identified during audit — no performance rules existed.
- **`security.mdc`** — Initial creation with secrets, input validation, common vulns, auth/authz, dependencies, data privacy.
- **`typescript.mdc`** — Strict typing, type design, imports/exports, patterns, common pitfalls. Scoped to `*.ts, *.tsx`.
- **`architecture.mdc`** — Core principles, SOLID, API design, state management, async patterns, patterns to avoid.
- **`git.mdc`** — Commits, branching, PRs, safety.
- **`planning.mdc`** + **`planning-templates.mdc`** — Planning workflow with lightweight always-loaded trigger and on-demand templates. Includes retrospective feedback loop for continuous rule improvement.
- **`CHANGELOG.md`** — This file. Tracks rule evolution for troubleshooting and retrospectives.
- **`README.md`** — Documentation for the rules system, setup, design principles.

### Changed

- **`code-quality.mdc`** — Renamed from `clean-code.mdc`. Removed duplicated sections (TDD/FIRST, SOLID/Classes, Systems, Boundaries) now owned by `testing.mdc` and `architecture.mdc`. Modernized from OOP/Java-centric to language-agnostic. Reduced from 165 to 91 lines.
- **`testing.mdc`** — Added Test Strategy (Pyramid) section: unit vs integration vs E2E. Added "test behavior not implementation" and "don't over-mock" rules.
- **`security.mdc`** — Added HTTP Security section (CORS, CSP, rate limiting, security headers). Added Server-Side Threats section (SSRF, DoS, prototype pollution).
- **`architecture.mdc`** — Added Observability section (structured logging, error tracking, health checks, metrics, correlation IDs).
- **`rules.md`** — Cleaned up to be a lean entry point. Removed Code Quality section (moved to `code-quality.mdc`). Added Communication section. Updated file reference table.
- **`planning.mdc`** — Split from single 180-line file into lightweight trigger (30 lines, always loaded) + templates file (on demand). Added retrospective feedback loop.

### Removed

- **`clean-code.mdc`** — Renamed to `code-quality.mdc`.

### Rationale

Initial buildout of comprehensive rules for a principal full-stack engineer. Organized by concern, with lightweight always-loaded rules and heavier files loaded on demand. Self-improving feedback loop added to planning workflow.
