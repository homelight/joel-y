#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PET_ID="joel-y"
SOURCE_DIR="$REPO_ROOT/pet/$PET_ID"
TARGET_ROOT="${CODEX_HOME:-$HOME/.codex}/pets"
TARGET_DIR="$TARGET_ROOT/$PET_ID"
SKILL_SOURCE_DIR="$REPO_ROOT/skills/$PET_ID"
SKILL_TARGET_ROOT="${CODEX_HOME:-$HOME/.codex}/skills"
SKILL_TARGET_DIR="$SKILL_TARGET_ROOT/$PET_ID"

if [[ ! -f "$SOURCE_DIR/pet.json" || ! -f "$SOURCE_DIR/spritesheet.webp" ]]; then
  echo "Missing pet package files in $SOURCE_DIR" >&2
  exit 1
fi

mkdir -p "$TARGET_ROOT"
rm -rf "$TARGET_DIR"
cp -R "$SOURCE_DIR" "$TARGET_DIR"

if [[ -d "$SKILL_SOURCE_DIR" ]]; then
  mkdir -p "$SKILL_TARGET_ROOT"
  rm -rf "$SKILL_TARGET_DIR"
  cp -R "$SKILL_SOURCE_DIR" "$SKILL_TARGET_DIR"
  echo "Installed $PET_ID skill to $SKILL_TARGET_DIR"
fi

echo "Installed $PET_ID to $TARGET_DIR"
echo "Restart Codex if Joel-y does not refresh immediately."
