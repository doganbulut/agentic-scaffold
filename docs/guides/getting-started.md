# Getting Started with agentic-scaffold

## Why This Exists

Every time you start a project, you have to tell your AI agent:

- "This is a TypeScript project with Vitest"
- "We use ESLint and Prettier"
- "Don't add type ignores"
- "Write tests before code"
- "Run CI before pushing"

**agentic-scaffold eliminates this.** The AI reads the project structure and already knows everything.

## Quick Start

```bash
# Clone the template
git clone https://github.com/YOUR_USER/agentic-scaffold my-project
cd my-project

# Install dependencies
npm install

# Initialize (renames project, sets up git)
npm run setup

# Start developing
npm run dev
```

## What You Get

### For Humans

```
my-project/
├── src/           # Your code
├── tests/         # Your tests
├── docs/          # Architecture records, specs, guides
├── scripts/       # CI scripts (Unix + Windows)
└── package.json   # Build, test, lint, format scripts
```

### For AI Agents

```
my-project/
├── CLAUDE.md            # Agent directive (rules, principles, workflow)
├── AGENTS.md            # Mirror of CLAUDE.md (cross-platform)
├── .claude/
│   ├── settings.json    # Permission allow-lists
│   ├── agents/          # Subagent prompt templates
│   ├── skills/          # Reusable workflow definitions
│   └── plans/           # Implementation task breakdowns
└── memory/              # Persistent agent memory (gitignored)
```

## AI-Agent Collaboration

Once inside this project, your AI agent:

1. **Reads CLAUDE.md** — learns architectural principles, coding conventions, testing requirements, versioning rules
2. **Activates skills** — brainstorming, TDD, systematic debugging, code review — each with defined workflows
3. **Uses subagents** — delegates bounded work to parallel subagents via templated prompts
4. **Runs CI** — `./scripts/ci.sh` or `.\scripts\ci.ps1` before every push

## CI/CD

```bash
# Local CI (runs format → lint → typecheck → test)
./scripts/ci.sh              # Unix
.\scripts\ci.ps1             # Windows

# Subset (during development)
./scripts/ci.sh --only test  # Only run tests
.\scripts\ci.ps1 -Only test  # Windows
```

GitHub CI runs 6 parallel checks on push/PR:

1. Ban type ignore suppressions
2. Format (Prettier)
3. Lint (ESLint)
4. Type check (TypeScript)
5. Unit + integration tests
6. E2E tests

## Workflows

### Adding a Feature

```
Think → Design → Plan → Implement → Review → Merge
```

1. **Brainstorming skill** — explore approaches, get approval
2. **Write spec** — `docs/specs/<feature>.md`
3. **Writing-plans skill** — decompose into task list
4. **TDD skill** — implement each task (red → green → refactor)
5. **Code review skill** — verify spec compliance + quality
6. Merge

### Fixing a Bug

```
Reproduce → Root Cause → Regression Test → Fix → Verify
```

1. **Systematic debugging skill** — structured root-cause analysis
2. Write regression test
3. Apply minimal fix
4. Run full CI

## Architecture Principles

- **Shared core** (`src/core/`) — no cross-module duplication
- **DRY** — extract shared classes; composition over copy-paste
- **Encapsulation** — accessor methods, no direct `_attribute` writes
- **Type safety** — fix types, never add `# type: ignore`
- **YAGNI** — nothing extra, nothing half-finished
- **Dead code** — remove in the same change; no compat shims

## Customization

1. Edit `package.json` — change name, description, scripts
2. Edit `CLAUDE.md` — update architecture principles to match your project
3. Edit `.claude/settings.json` — adjust permission allow-lists
4. Add skills in `.claude/skills/` — each skill gets a `SKILL.md`
5. Write specs in `docs/specs/` — before implementing features
