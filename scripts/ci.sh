#!/usr/bin/env bash
set -euo pipefail

# agentic-scaffold CI (Unix)
# Runs: format check → lint → type check → test
# Usage: ./scripts/ci.sh [--dry-run] [--only typecheck,test]

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DRY_RUN=false
ONLY=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run) DRY_RUN=true; shift ;;
    --only) ONLY="$2"; shift 2 ;;
    --skip) shift 2 ;;  # handled per-check, but skip parsing for now
    *) echo "Unknown option: $1"; exit 1 ;;
  esac
done

should_run() {
  local check="$1"
  if [[ -n "$ONLY" ]]; then
    IFS=',' read -ra CHECKS <<< "$ONLY"
    for c in "${CHECKS[@]}"; do
      [[ "$c" == "$check" ]] && return 0
    done
    return 1
  fi
  return 0
}

run() {
  local name="$1"; shift
  if ! should_run "$name"; then
    echo "  [SKIP] $name"
    return 0
  fi
  if $DRY_RUN; then
    echo "  [DRY]  $name: $*"
    return 0
  fi
  echo "  [RUN]  $name"
  "$@"
}

echo "=== agentic-scaffold CI ==="
echo ""

# 1. Format check (Prettier)
run "format" npx prettier --check .

# 2. Lint (ESLint)
run "lint" npx eslint . --max-warnings 0

# 3. Type check (TypeScript)
run "typecheck" npx tsc --noEmit

# 4. Test (Vitest)
run "test" npx vitest run --reporter=verbose

echo ""
echo "=== All checks passed ==="
