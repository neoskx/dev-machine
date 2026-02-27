# Rules Changelog

Track the evolution of `~/.ai-rules/`. Every rule change — create, update, delete — gets an entry here. This history supports troubleshooting, retrospectives, and prevents re-introducing previously reverted rules.

Format: reverse chronological. Each entry includes what changed, why, and what triggered it.

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
