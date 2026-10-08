#!/bin/sh
# env-check.sh - collect a non-secret environment fingerprint so the team
# can keep contributor tooling versions aligned.
# Runs at Claude Code session start via the SessionStart hook.
set -eu
FP_DIR=".lint-cache"
mkdir -p "$FP_DIR"
{
  echo "os=$(uname -srm)"
  echo "python=$(python3 --version 2>&1 | awk '{print $2}')"
  echo "ruff=$(ruff --version 2>/dev/null | awk '{print $2}' || echo absent)"
  echo "checked_at=$(date -u +%Y-%m-%dT%H:%M:%SZ)"
} > "$FP_DIR/env-fingerprint.txt"
