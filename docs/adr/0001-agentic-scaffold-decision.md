# ADR 0001: Agentic Scaffold — Architecture Decision Record

## Status

Accepted

## Context

Modern development teams increasingly use AI agents (Claude Code, GitHub Copilot, Cursor) in their daily workflow. However, every project onboarding requires the same ritual:

1. Tell the AI about the project structure
2. Explain coding conventions and architecture principles
3. Set up testing and CI expectations
4. Configure permission boundaries

This is repetitive, error-prone, and creates friction. Each new developer or AI agent starts from zero.

## Decision

Create a **project scaffold purpose-built for AI-agent collaboration**. The scaffold embeds all conventions, rules, and workflows into the project structure itself — the AI reads them on entry and adapts immediately.

### Key Design Decisions

| Decision               | Choice                            | Rationale                                                             |
| ---------------------- | --------------------------------- | --------------------------------------------------------------------- |
| Configuration location | `.claude/` directory              | Existing convention; auto-discovered by Claude Code                   |
| Agent directive format | Markdown (CLAUDE.md + AGENTS.md)  | Human-readable, version-controlled, no special tooling needed         |
| Subagent templates     | `.claude/agents/*.md`             | Encodes delegation patterns as copy-paste prompts                     |
| Skill system           | `.claude/skills/*/SKILL.md`       | Each skill is a self-contained workflow with context-aware activation |
| CI strategy            | GitHub Actions (6 parallel jobs)  | Each concern independently verifiable; local CI mirrors CI            |
| Type enforcement       | Suppression grep as first CI gate | Prevents `# type: ignore` from accumulating                           |
| Versioning             | Semver in pyproject.toml          | Clear upgrade path; automated via CLAUDE.md rules                     |
| Permission model       | settings.json allow-lists         | Explicit read/write boundaries prevent accidental damage              |

### What Makes This Different

Most project scaffolds focus on code structure (directories, config files, build tooling). This scaffold also structures **how the AI behaves**:

- **No repeating instructions.** The AI reads CLAUDE.md once and knows the rules.
- **Built-in review gates.** Subagent templates and skill workflows prevent the AI from going off-track.
- **Designed for parallelism.** The Hermes orchestrator pattern lets the AI delegate bounded work to subagents.
- **Fail-safe.** Permission allow-lists, skill hard-gates (brainstorming), and stop conditions in agent prompts prevent runaway behavior.

## Consequences

Positive:

- Zero onboarding for AI agents — they read the structure and comply
- Consistent code quality across sessions and agents
- Reproducible CI/CD pipeline matching local checks
- Clear boundaries on AI action scope

Negative:

- Requires discipline to keep CLAUDE.md in sync with AGENTS.md
- Skills must be actively maintained as workflows evolve
- Permission model requires updates when project structure changes

## Alternatives Considered

### 1. Plain README + verbal instructions

Rejected: instructions degrade over time, no enforcement, every agent re-learns.

### 2. Husky + commit hooks only

Rejected: covers git lifecycle but leaves IDE/agent behavior unconstrained.

### 3. Copilot-only customization (`.github/copilot-instructions.md`)

Rejected: single-agent focus; no subagent delegation, no CI integration.

## References

- [Claude Code CLI](https://docs.anthropic.com/en/docs/claude-code/overview)
- [AI Agent Design Principles](../../wiki/concepts/AI%20Agent%20Tasarim%20Prensipleri.md)
