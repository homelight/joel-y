#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/homelight/joel-y.git"
PET_ID="joel-y"
CODEX_ROOT="${CODEX_HOME:-$HOME/.codex}"
DEFAULT_REPO_DIR="$CODEX_ROOT/joel-y-repo"
REPO_DIR=""
REF="main"
MODE="latest"

usage() {
  cat <<'USAGE'
Usage:
  update-joel-y.sh --latest [--repo-dir PATH]
  update-joel-y.sh --ref REF [--repo-dir PATH]
  update-joel-y.sh --list [--repo-dir PATH]
  update-joel-y.sh --status

Options:
  --latest         Install the latest Joel-y from origin/main.
  --ref REF        Install a specific tag, branch, or commit.
  --list           List recent tags and remote branches.
  --status         Show installed Joel-y metadata.
  --repo-dir PATH  Use or clone the Joel-y repo at PATH.
  --help           Show this help.
USAGE
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --latest)
      MODE="latest"
      REF="main"
      shift
      ;;
    --ref)
      MODE="ref"
      REF="${2:?Missing value for --ref}"
      shift 2
      ;;
    --list)
      MODE="list"
      shift
      ;;
    --status)
      MODE="status"
      shift
      ;;
    --repo-dir)
      REPO_DIR="${2:?Missing value for --repo-dir}"
      shift 2
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

if [[ "$MODE" == "status" ]]; then
  PET_DIR="$CODEX_ROOT/pets/$PET_ID"
  if [[ ! -f "$PET_DIR/pet.json" ]]; then
    echo "Joel-y is not installed at $PET_DIR"
    exit 1
  fi
  echo "Installed Joel-y:"
  cat "$PET_DIR/pet.json"
  echo
  [[ -f "$PET_DIR/spritesheet.webp" ]] && echo "spritesheet: $PET_DIR/spritesheet.webp"
  exit 0
fi

if [[ -z "$REPO_DIR" ]]; then
  if git rev-parse --show-toplevel >/dev/null 2>&1; then
    CANDIDATE="$(git rev-parse --show-toplevel)"
    if [[ -f "$CANDIDATE/pet/$PET_ID/pet.json" && -f "$CANDIDATE/pet/$PET_ID/spritesheet.webp" ]]; then
      REPO_DIR="$CANDIDATE"
    else
      REPO_DIR="$DEFAULT_REPO_DIR"
    fi
  else
    REPO_DIR="$DEFAULT_REPO_DIR"
  fi
fi

if [[ ! -d "$REPO_DIR/.git" ]]; then
  mkdir -p "$(dirname "$REPO_DIR")"
  git clone "$REPO_URL" "$REPO_DIR"
fi

cd "$REPO_DIR"
git fetch --tags origin

if [[ "$MODE" == "list" ]]; then
  echo "Tags:"
  git tag --sort=-creatordate | head -20
  echo
  echo "Branches:"
  git branch -r | sed 's/^ *//' | grep -v 'HEAD' | head -20
  exit 0
fi

if [[ "$MODE" == "latest" ]]; then
  git checkout main
  git pull --ff-only origin main
else
  git checkout --detach "$REF"
fi

SOURCE_DIR="$REPO_DIR/pet/$PET_ID"
TARGET_ROOT="$CODEX_ROOT/pets"
TARGET_DIR="$TARGET_ROOT/$PET_ID"

if [[ ! -f "$SOURCE_DIR/pet.json" || ! -f "$SOURCE_DIR/spritesheet.webp" ]]; then
  echo "Ref '$REF' does not contain a complete Joel-y pet package." >&2
  echo "Expected $SOURCE_DIR/pet.json and $SOURCE_DIR/spritesheet.webp" >&2
  exit 1
fi

mkdir -p "$TARGET_ROOT"
rm -rf "$TARGET_DIR"
cp -R "$SOURCE_DIR" "$TARGET_DIR"

echo "Installed Joel-y from '$REF' to $TARGET_DIR"
echo "Restart Codex if Joel-y does not refresh immediately."
