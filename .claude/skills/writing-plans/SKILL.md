---
name: writing-plans
description: 'Load after design approval to decompose the design into an ordered, implementable task list with dependencies.'
---

# Writing Plans Skill

Load this skill after: a design doc has been approved and implementation is ready to begin. This skill breaks the approved design into concrete, ordered tasks.

## Workflow

1. Read the approved design doc
2. Decompose into implementation tasks:
   - Each task is: one file added/modified, or one logical change
   - Tasks should be independently implementable and testable
   - Order by dependency — what must exist before what
3. For each task, write a brief file (`.claude/plans/task-N-<slug>.md`):
   - What to implement
   - Which files to create or modify
   - Acceptance criteria
   - Test requirements
4. Review task breakdown:
   - Completeness: does this cover the full design?
   - Gaps: what's missing between tasks?
   - Parallelism: which tasks can run in parallel?

## Task File Template (.claude/plans/task-N-slug.md)

```markdown
# Task N: Task Name

## Description

[What to implement, referencing the design doc]

## Files

- **New:** `src/features/x/y.ts`
- **Modify:** `src/core/z.ts` (add function)

## Acceptance Criteria

- [ ] [Criterion 1]
- [ ] [Criterion 2]

## Dependencies

- Blocked by: Task N-1
- Blocks: Task N+1

## Test Plan

- [ ] Unit test for new function
- [ ] Integration test covers the scenario
```
