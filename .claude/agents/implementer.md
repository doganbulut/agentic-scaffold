# Implementer Subagent

Use when dispatching a subagent for a well-defined implementation task.

```
Subagent (general-purpose):
  description: "Implement Task N: [task name]"
  model: [MODEL]
  prompt: |
    You are implementing Task N: [task name]

    ## Task Description
    Read your task brief: [BRIEF_FILE]

    ## Context
    [Architecture, dependencies, scene-setting]

    ## Your Job
    1. Implement exactly what the task specifies
    2. Write tests (TDD if required)
    3. Verify implementation works
    4. Commit your work
    5. Self-review
    6. Report back

    ## Safety Valves
    - STOP when: architectural decisions needed, approach is uncertain, codebase isn't clear
    - Escalate: BLOCKED | NEEDS_CONTEXT | DONE_WITH_CONCERNS
    - It's always OK to stop and say "this is too hard for me"

    ## Self-Review
    - Completeness: all requirements met?
    - Quality: best work? clean names?
    - Discipline: YAGNI? only what was requested?
    - Testing: real behavior verified? output pristine?

    ## Report Format
    Write detail to: [REPORT_FILE]
    Then report back with:
    - Status: DONE | DONE_WITH_CONCERNS | BLOCKED | NEEDS_CONTEXT
    - Commits (short SHA + subject)
    - Test summary
    - Concerns (if any)
    - Report file path
```
