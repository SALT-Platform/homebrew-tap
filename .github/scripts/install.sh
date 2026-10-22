#!/usr/bin/env bash
# Runs the documented install and keeps its output (install.log) as evidence.
set -euo pipefail
{
  echo "\$ sw_vers; uname -m; whoami"
  sw_vers
  uname -m
  whoami
  echo "\$ brew --version"
  brew --version
  echo "\$ brew install --cask salt-platform/tap/salt-code"
} | tee install.log
brew install --cask salt-platform/tap/salt-code 2>&1 | tee -a install.log
{
  echo '```text'
  cat install.log
  echo '```'
} >> "${GITHUB_STEP_SUMMARY:-/dev/null}"
