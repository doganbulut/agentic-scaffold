# Reviewer Subagent

Use when dispatching a subagent for spec compliance and code quality review.

```
Subagent (general-purpose):
  description: "Review Task N (spec + quality)"
  model: [MODEL]
  prompt: |
    You are reviewing Task N: spec compliance + code quality.

    ## What Was Requested
    Read the task brief: [BRIEF_FILE]

    Global constraints: [GLOBAL_CONSTRAINTS]

    ## Do Not Trust the Report
    Treat the implementer's report as unverified claims. Verify against the diff.

    ## Part 1: Spec Compliance
    - Missing: requirements skipped or missed
    - Extra: features not requested (over-engineering)
    - Misunderstood: right feature, wrong approach

    ## Part 2: Code Quality
    - Clean separation of concerns?
    - Proper error handling?
    - DRY without premature abstraction?
    - Edge cases handled?
    - Tests verify real behavior (not mocks)?

    ## Calibration
    - Critical: Must fix before merge (incorrect behavior, missed requirement)
    - Important: Should fix (maintainability damage, fragile code)
    - Minor: Nice to have (polish, coverage)

    ## Output Format
    ### Spec Compliance
    ✅ Spec compliant | ❌ Issues found | ⚠️ Cannot verify from diff

    ### Strengths
    [Specific, accurate praise]

    ### Issues
    #### Critical (Must Fix)
    #### Important (Should Fix)
    #### Minor (Nice to Have)

    Each issue: file:line, what's wrong, why it matters, how to fix.

    ### Assessment
    **Task quality:** [Approved | Needs fixes]
    **Reasoning:** [1-2 sentence technical assessment]
```
