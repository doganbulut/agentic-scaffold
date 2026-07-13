#!/usr/bin/env node

/**
 * agentic-scaffold setup script.
 * Run after cloning the template to initialize a new project.
 *
 * Usage: node init/setup.mjs
 *
 * What it does:
 *   1. Prompts for the new project name (or uses current directory name)
 *   2. Updates package.json with the new name
 *   3. Initializes git if not already initialized
 *   4. Creates initial commit
 */

import { readFileSync, writeFileSync } from 'fs';
import { join, basename, resolve } from 'path';
import { execSync } from 'child_process';

const ROOT = resolve(import.meta.dirname, '..');
const DEFAULT_NAME = basename(ROOT).replace(/\s+/g, '-').toLowerCase();

function readPackage() {
  const path = join(ROOT, 'package.json');
  return JSON.parse(readFileSync(path, 'utf-8'));
}

function writePackage(pkg) {
  const path = join(ROOT, 'package.json');
  writeFileSync(path, JSON.stringify(pkg, null, 2) + '\n');
}

function isGitRepo() {
  try {
    execSync('git rev-parse --git-dir', { cwd: ROOT, stdio: 'ignore' });
    return true;
  } catch {
    return false;
  }
}

function main() {
  // 1. Get project name
  const projectName = process.argv[2] || DEFAULT_NAME;
  console.log(`\n🔧 Setting up project: ${projectName}\n`);

  // 2. Update package.json
  const pkg = readPackage();
  const oldName = pkg.name;
  pkg.name = projectName;
  pkg.version = '0.1.0';
  delete pkg.keywords;
  writePackage(pkg);
  console.log(`  ✓ Updated package.json: ${oldName} → ${projectName}`);

  // 3. Initialize git if needed
  if (!isGitRepo()) {
    execSync('git init', { cwd: ROOT, stdio: 'inherit' });
    console.log('  ✓ Git repository initialized');
  } else {
    console.log('  ~ Git repository already exists');
  }

  // 4. Create initial commit
  execSync('git add -A', { cwd: ROOT, stdio: 'inherit' });
  execSync('git commit -m "chore: initial scaffold from agentic-scaffold"', {
    cwd: ROOT,
    stdio: 'inherit',
  });
  console.log('  ✓ Initial commit created\n');
  console.log(`🚀 Project "${projectName}" is ready!\n`);
  console.log('  Next steps:');
  console.log('    1. npm install');
  console.log('    2. npm run dev');
  console.log('');
}

main();
