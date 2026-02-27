# Personal AI Agent Rules — Neo

These are my personal defaults. They apply to ALL projects as a baseline.

**Priority**: Project-specific rules (`.cursor/rules/`, `.ai/rules/`, `CLAUDE.md`, `AI-AGENTS.md`) always take precedence over these personal rules. If a project rule conflicts with a rule here, follow the project rule.

**Additional rule files**: Read ALL `.md` and `.mdc` files in `~/.ai-rules/` — they are part of these personal rules. Currently:
- `~/.ai-rules/rules.md` — This file (general rules)
- `~/.ai-rules/clean-code.mdc` — Clean code standards

## Code Quality

1. **No unnecessary code** — Don't create files, tests, or abstractions that don't add real value. If a component is a thin wrapper around a single dependency, don't write a test that just mocks that dependency.
2. **No unnecessary tests for thin wrappers** — If the only way to test a component is to mock its sole dependency, the test is tautological. Test the logic at a higher level instead.
3. **Follow existing patterns** — Before creating anything, check how the codebase already does it. Match the conventions exactly.
4. **No console.log/console.error in production code** — Only for local development, remove before committing.

## Testing

1. **Mock at the network level, not the component level** — Prefer mocking HTTP/API calls over mocking React components. If you must mock a component, acknowledge the limitation.
2. **Don't write tests just for coverage** — Every test should verify meaningful behavior that could actually break.
3. **Follow project test conventions first** — Check existing test files in the same directory before writing new ones.

## Process

1. **Read and follow project rules first** — Always read the project's `.ai/rules/`, `.cursor/rules/`, `CLAUDE.md`, or `AI-AGENTS.md` before starting work. Project rules override anything here.
2. **Ask before creating new files** — If unsure whether a new file is needed, ask. Prefer editing existing files.
3. **Don't over-engineer** — Solve the problem at hand. Don't add abstractions "for the future."

## Skills

(Add specific skills/workflows here as needed)
