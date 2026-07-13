# Claude Hooks

Hooks are shell commands that execute in response to events like tool calls.

See https://docs.anthropic.com/en/docs/claude-code/overview for hook documentation.

## Available Hooks

- `pre-tool-call` — Runs before every tool call
- `post-tool-call` — Runs after every tool call
- `user-prompt-submit` — Runs when the user submits a prompt

## Example: Pre-commit quality gate

Create `pre-tool-call` (no extension):

```bash
#!/bin/bash
# Prevent commits with debug artifacts
if [[ "$TOOL_NAME" == "Bash" && "$TOOL_INPUT" == *"git commit"* ]]; then
  if git diff --cached | grep -q "debugger\|console.log"; then
    echo "❌ Cannot commit: debug artifacts found"
    exit 1
  fi
fi
```
