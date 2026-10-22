#!/usr/bin/env bash
# Pull requests: tap main as a teammate would, then lay this change's casks over it.
set -euo pipefail
src="${1:?usage: overlay-cask.sh <checkout>}"
brew tap salt-platform/tap
tap="$(brew --repo salt-platform/tap)"
mkdir -p "$tap/Casks"
cp "$src"/Casks/*.rb "$tap/Casks/"
