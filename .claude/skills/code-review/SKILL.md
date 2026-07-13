---
name: code-review
description: 'Load before merging. Spec compliance audit + code quality review. Uses subagent reviewer for independent assessment.'
---

# Code Review Skill

Load this skill before: merging any PR or committing significant changes. This skill ensures spec compliance and code quality through a structured review process.

## Workflow

### Part 1: What Was Requested

- Read the task brief or issue description
- Read the CLAUDE.md architecture principles
- Understand the acceptance criteria

### Part 2: Spec Compliance

- **Missing**: requirements skipped or missed
- **Extra**: features not requested (over-engineering)
- **Misunderstood**: right feature, wrong approach

### Part 3: Code Quality

- Clean separation of concerns?
- Proper error handling?
- DRY without premature abstraction?
- Edge cases handled?
- Tests verify real behavior (not mocks)?
- Performance considerations?

### Part 4: Independent Review (optional)

For significant changes, dispatch the reviewer subagent:

- Prompt with: task brief, diff or files changed, global constraints from CLAUDE.md
- The reviewer returns structured findings

### Part 5: Merge Decision

- **Critical**: Must fix before merge
- **Important**: Should fix
- **Minor**: Nice to have
- Apply fixes if critical or important. Merge only after all critical issues resolved.

## Review Checklist

- [ ] Spec compliance: all requirements met?
- [ ] YAGNI: no extra features?
- [ ] Naming: clear and consistent?
- [ ] Errors: meaningful messages, not swallowed?
- [ ] Edge cases: empty state, error state, boundary values?
- [ ] Tests: cover the specified behavior?
- [ ] Type safety: no `any` or type ignores?
- [ ] Dead code: no leftovers?
- [ ] Dependencies: no new deps if avoidable?
