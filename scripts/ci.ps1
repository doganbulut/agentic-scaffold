#!/usr/bin/env pwsh
# agentic-scaffold CI (Windows)
# Runs: format check, lint, type check, test
param(
  [switch]$DryRun,
  [string]$Only
)

$Root = Split-Path -Parent $PSScriptRoot

function Should-Run($check) {
  if ($Only) {
    return $Only.Split(',') -contains $check
  }
  return $true
}

function Run($name, $command) {
  if (-not (Should-Run $name)) {
    Write-Host "  [SKIP] $name"
    return
  }
  if ($DryRun) {
    Write-Host "  [DRY]  ${name}: ${command}"
    return
  }
  Write-Host "  [RUN]  $name"
  Invoke-Expression $command
  if ($LASTEXITCODE -and $LASTEXITCODE -ne 0) {
    Write-Host "  [FAIL] $name (exit $LASTEXITCODE)"
    exit $LASTEXITCODE
  }
}

Write-Host "=== agentic-scaffold CI ==="
Write-Host ""

Run "format" "npx prettier --check ."
Run "lint" "npx eslint . --max-warnings 0"
Run "typecheck" "npx tsc --noEmit"
Run "test" "npx vitest run --reporter=verbose"

Write-Host ""
Write-Host "=== All checks passed ==="
