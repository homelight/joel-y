#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PET_ID="joel-y"
TARGET_ROOT="${CODEX_HOME:-$HOME/.codex}/pets"
TARGET_DIR="$TARGET_ROOT/$PET_ID"
SKILL_SOURCE_DIR="$REPO_ROOT/skills/$PET_ID"
SKILL_TARGET_ROOT="${CODEX_HOME:-$HOME/.codex}/skills"
SKILL_TARGET_DIR="$SKILL_TARGET_ROOT/$PET_ID"
RELEASE_INDEX="$REPO_ROOT/releases/index.json"
MODE="latest"
RELEASE_ID=""

usage() {
  cat <<'USAGE'
Usage:
  install-or-update.sh [--latest]
  install-or-update.sh --release RELEASE_ID
  install-or-update.sh --list

Options:
  --latest              Install the release marked latest in releases/index.json.
  --release RELEASE_ID  Install a specific versioned Joel-y release.
  --list                List available versioned Joel-y releases.
  --help                Show this help.
USAGE
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --latest)
      MODE="latest"
      shift
      ;;
    --release)
      MODE="release"
      RELEASE_ID="${2:?Missing value for --release}"
      shift 2
      ;;
    --list)
      MODE="list"
      shift
      ;;
    --help|-h)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

if [[ ! -f "$RELEASE_INDEX" ]]; then
  echo "Missing release index: $RELEASE_INDEX" >&2
  exit 1
fi

if [[ "$MODE" == "list" ]]; then
  jq -r '.releases[] | "\(.id)\t\(.displayName)\t\(.description)"' "$RELEASE_INDEX"
  exit 0
fi

if [[ "$MODE" == "latest" ]]; then
  RELEASE_ID="$(jq -r '.latest' "$RELEASE_INDEX")"
fi

SOURCE_REL="$(jq -r --arg id "$RELEASE_ID" '.releases[] | select(.id == $id) | .path' "$RELEASE_INDEX")"
if [[ -z "$SOURCE_REL" || "$SOURCE_REL" == "null" ]]; then
  echo "Unknown Joel-y release: $RELEASE_ID" >&2
  echo "Available releases:" >&2
  jq -r '.releases[] | "- \(.id)"' "$RELEASE_INDEX" >&2
  exit 1
fi

SOURCE_DIR="$REPO_ROOT/$SOURCE_REL"

if [[ ! -f "$SOURCE_DIR/pet.json" || ! -f "$SOURCE_DIR/spritesheet.webp" || ! -f "$SOURCE_DIR/release.json" ]]; then
  echo "Release '$RELEASE_ID' is incomplete in $SOURCE_DIR" >&2
  exit 1
fi

if [[ ! -f "$SOURCE_DIR/contact-sheet.png" ]]; then
  echo "Release '$RELEASE_ID' is missing contact-sheet.png in $SOURCE_DIR" >&2
  exit 1
fi

mkdir -p "$TARGET_ROOT"
rm -rf "$TARGET_DIR"
mkdir -p "$TARGET_DIR"
cp "$SOURCE_DIR/pet.json" "$TARGET_DIR/pet.json"
cp "$SOURCE_DIR/spritesheet.webp" "$TARGET_DIR/spritesheet.webp"

if [[ -d "$SKILL_SOURCE_DIR" ]]; then
  mkdir -p "$SKILL_TARGET_ROOT"
  rm -rf "$SKILL_TARGET_DIR"
  cp -R "$SKILL_SOURCE_DIR" "$SKILL_TARGET_DIR"
  echo "Installed $PET_ID skill to $SKILL_TARGET_DIR"
fi

echo "Installed $PET_ID release '$RELEASE_ID' to $TARGET_DIR"
echo "Restart Codex if Joel-y does not refresh immediately."
