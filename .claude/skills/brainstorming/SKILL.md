---
name: brainstorming
description: 'Load before any creative/implementation work that needs design decisions. Implements a hard gate: no code without approved design.'
---

# Brainstorming Skill

Load this skill when: the user wants to design something new, explore alternatives, or make architectural decisions. This skill implements a **hard gate** — no code is written until design is approved.

## Workflow

1. User states the problem or feature idea
2. You propose 2-3 distinct approaches, each with trade-offs:
   - Keep descriptions to ~3 sentences each
   - Lead with the structural difference, not implementation details
   - Name concrete costs (complexity, dependencies, trade-offs)
3. Ask clarifying questions — one at a time. Never dump a list.
4. After user selects an approach, produce a brief design doc (docs/specs/)
5. Do NOT start implementation until user explicitly approves the design

## Design Doc Template (docs/specs/<feature>.md)

- Context & Motivation
- Chosen Approach (with rationale)
- Key Design Decisions
- API / Data Model (if relevant)
- Open Questions (if any)

## Examples

```
User: "I need to add caching to the API"
You: "Three approaches:
1. **In-memory LRU cache** — simplest, zero infra, lost on restart.
   Best for single-instance, low-traffic APIs.
2. **Redis** — persistent, shared across instances, great TTL support.
   Adds Redis to your stack and ops overhead.
3. **CDN caching (Cloudflare/Varnish)** — best for read-heavy public
   endpoints. No app changes needed but won't help authenticated data.

Which direction fits your constraints?"

User: "Redis actually, we already run it for queues"
You: "Let me draft a design spec and share it."
```

## Calibration

- If the problem is small and the best approach is obvious, don't use this skill — just implement
- If you're >80% certain of the right approach, propose it first with 1 alternative
- Architectural decisions (auth, data model, deployment) always need at least 2 options
- Prefer concrete comparisons over abstract principles
