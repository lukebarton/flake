#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/lukebarton/flake.git"
REPO_DIR="$HOME/src/github.com/lukebarton/flake"

if xcode-select -p >/dev/null 2>&1; then
  printf '\033[1;34m==> Xcode Command Line Tools already installed\033[0m\n'
else
  printf '\033[1;34m==> Installing Xcode Command Line Tools...\033[0m\n'
  xcode-select --install
  printf '\033[1;33m==> Waiting for installation to complete (follow the GUI prompt)...\033[0m\n'
  until xcode-select -p >/dev/null 2>&1; do
    sleep 5
  done
fi

if [ -d "$REPO_DIR/.git" ]; then
  printf '\033[1;34m==> Repo already cloned, pulling latest...\033[0m\n'
  git -C "$REPO_DIR" pull --ff-only
else
  printf '\033[1;34m==> Cloning repo to %s...\033[0m\n' "$REPO_DIR"
  mkdir -p "$(dirname "$REPO_DIR")"
  git clone "$REPO_URL" "$REPO_DIR"
fi

cd "$REPO_DIR"
make bootstrap
