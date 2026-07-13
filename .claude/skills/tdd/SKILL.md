---
name: tdd
description: 'Load when implementing features. Strict Red → Green → Refactor cycle. Write the failing test first, then implement, then refactor.'
---

# TDD Skill

Load this skill when: implementing a new feature, adding a function, or fixing a bug with a clear reproduction. Follow strict Red → Green → Refactor.

## Workflow

### Red Phase

1. Understand the requirement. Ask clarifying questions if needed.
2. Write a **failing test** that captures the desired behavior.
3. Run the test — confirm it fails (compilation error counts as failure).
4. Only write enough of the production interface to make test failures meaningful.

### Green Phase

5. Write the **simplest code** that makes the test pass.
   - Duplication is acceptable. Hardcoding is acceptable for one case.
   - Do not generalize beyond what the test demands.
6. Run the test — confirm it passes.
7. Do not clean up yet. First green is sacred.

### Refactor Phase

8. Now clean up: remove duplication, extract helpers, improve names.
9. Run the test — confirm it still passes after each change.
10. If tests turn red during refactor, revert the last change.

## Rules

- **One assertion pattern per test case.** A test function verifies one behavior.
- **Each test is independent.** No shared mutable state between tests.
- **Test names describe the scenario and expected outcome:**
  `should_return_error_when_email_is_invalid`
- **Use descriptive variable names** in tests even where production code uses short ones.
- **Test boundary conditions** — empty input, null, max values, overflow.
- **Test error paths** — every documented error case must have a test.
- **Never modify production code to make a test pass** in a way that violates encapsulation.
- **Don't test framework behavior.** Test your logic, not the framework's.

## Example

```
### Red
test('should reject order when credit limit exceeded', () => {
  const dealer = new Dealer({ creditLimit: 1000, currentBalance: 1500 });
  const result = dealer.canPlaceOrder(200);
  expect(result.allowed).toBe(false);
  expect(result.reason).toBe('CREDIT_LIMIT_EXCEEDED');
});
// Confirm test fails: TypeError: dealer.canPlaceOrder is not a function

### Green
canPlaceOrder(amount: number): { allowed: boolean; reason?: string } {
  if (this.currentBalance + amount > this.creditLimit) {
    return { allowed: false, reason: 'CREDIT_LIMIT_EXCEEDED' };
  }
  return { allowed: true };
}
// Test passes

### Refactor
// Extract credit check into reusable method
private checkCreditLimit(amount: number): boolean {
  return this.currentBalance + amount > this.creditLimit;
}
// Test still passes
```
