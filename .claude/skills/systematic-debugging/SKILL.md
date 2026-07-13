---
name: systematic-debugging
description: 'Load when fixing bugs. Root-cause analysis → regression test → fix → verify. Never treat symptoms.'
---

# Systematic Debugging Skill

Load this skill when: a test is failing, a bug is reported, or behavior doesn't match specification. This skill enforces a **root-cause only** discipline — never fix symptoms.

## Workflow

### 1. Reproduce

- Run the failing test or reproduction scenario
- Capture exact error message, stack trace, and input
- If intermittent, note frequency and environment

### 2. Root-Cause Analysis

- Read the error — understand what actually failed, not where it surfaced
- Trace backwards: error location → immediate cause → deeper cause → true root
- Check: wrong value? missing null check? incorrect assumption? race condition?
- **Do not guess.** Read the relevant source code. Add logging if needed.
- Stop when you can answer: "The specific line/condition that causes this is..."

### 3. Regression Test

- Write a test that fails **before** your fix and passes **after**
- If a test already exists, add a new case for the uncovered scenario
- This test becomes permanent — it prevents regression

### 4. Fix

- Change the minimum code necessary to address the **root cause**
- If the root cause is in caller and callee, fix it where it's owned — not at the symptom
- Verify: run the regression test + all related tests
- Check for sibling bugs (same pattern elsewhere)

### 5. Verify

- Run full test suite
- Run any relevant smoke tests
- Log output must be clean

## Discipline

- **No shotgun debugging** — do not change things hoping they help
- **One fix at a time** — if multiple bugs, fix and commit separately
- **If stuck for >5 minutes**, articulate your hypothesis out loud (or write it down) — the act of writing often reveals the gap

## Debugging Checklist

- [ ] Reproduced the failure
- [ ] Identified root cause (not just symptom)
- [ ] Wrote regression test (fails before, passes after)
- [ ] Applied minimal fix
- [ ] Verified fix + no regressions
- [ ] Checked for same pattern elsewhere
- [ ] Committed with root cause in commit message

## Example

```
Bug: "Order total shows $NaN when discount is 0%"

Root cause analysis:
- Template renders: `{{ (subtotal * (1 - discountRate)).toFixed(2) }}`
- When discountRate is 0, it's the string "0" (from form input)
- `1 - "0"` → `"10"` (string concatenation, not subtraction)
- Root cause: missing parseFloat on form input

Regression test:
test('should calculate total with string discount rate', () => {
  const result = calculateTotal(100, "0");
  expect(result).toBe(100.00);
});

Fix:
function calculateTotal(subtotal: number, discountRate: string): number {
  const rate = parseFloat(discountRate) / 100;
  return subtotal * (1 - rate);
}

Sibling check: searched for other uses of discountRate — found 2 more
places without parseFloat. Fixed all.
```
