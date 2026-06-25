#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/homelight/joel-y.git"
PET_ID="joel-y"
CODEX_ROOT="${CODEX_HOME:-$HOME/.codex}"
DEFAULT_REPO_DIR="$CODEX_ROOT/joel-y-repo"
REPO_DIR=""
REF="main"
MODE="latest"
RELEASE_ID=""

usage() {
  cat <<'USAGE'
Usage:
  update-joel-y.sh --latest [--repo-dir PATH]
  update-joel-y.sh --release RELEASE_ID [--repo-dir PATH]
  update-joel-y.sh --ref REF [--repo-dir PATH]
  update-joel-y.sh --list [--repo-dir PATH]
  update-joel-y.sh --status

Options:
  --latest         Install the release marked latest from origin/main.
  --release ID     Install a specific versioned release from releases/index.json.
  --ref REF        Install latest from a specific git tag, branch, or commit.
  --list           List versioned releases, tags, and remote branches.
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
    --release)
      MODE="release"
      RELEASE_ID="${2:?Missing value for --release}"
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

if [[ "$MODE" == "latest" ]]; then
  git checkout main
  git pull --ff-only origin main
elif [[ "$MODE" == "ref" ]]; then
  git checkout --detach "$REF"
fi

RELEASE_INDEX="$REPO_DIR/releases/index.json"
if [[ ! -f "$RELEASE_INDEX" ]]; then
  echo "Missing release index: $RELEASE_INDEX" >&2
  exit 1
fi

if [[ "$MODE" == "list" ]]; then
  echo "Versioned releases:"
  jq -r '.releases[] | "\(.id)\t\(.displayName)\t\(.description)"' "$RELEASE_INDEX"
  echo
  echo "Git tags:"
  git tag --sort=-creatordate | head -20
  echo
  echo "Branches:"
  git branch -r | sed 's/^ *//' | grep -v 'HEAD' | head -20
  exit 0
fi

if [[ "$MODE" == "latest" || "$MODE" == "ref" ]]; then
  RELEASE_ID="$(jq -r '.latest' "$RELEASE_INDEX")"
fi

SOURCE_REL="$(jq -r --arg id "$RELEASE_ID" '.releases[] | select(.id == $id) | .path' "$RELEASE_INDEX")"
if [[ -z "$SOURCE_REL" || "$SOURCE_REL" == "null" ]]; then
  echo "Unknown Joel-y release: $RELEASE_ID" >&2
  echo "Available releases:" >&2
  jq -r '.releases[] | "- \(.id)"' "$RELEASE_INDEX" >&2
  exit 1
fi

SOURCE_DIR="$REPO_DIR/$SOURCE_REL"
TARGET_ROOT="$CODEX_ROOT/pets"
TARGET_DIR="$TARGET_ROOT/$PET_ID"

if [[ ! -f "$SOURCE_DIR/pet.json" || ! -f "$SOURCE_DIR/spritesheet.webp" || ! -f "$SOURCE_DIR/release.json" || ! -f "$SOURCE_DIR/contact-sheet.png" ]]; then
  echo "Release '$RELEASE_ID' is incomplete." >&2
  echo "Expected pet.json, spritesheet.webp, contact-sheet.png, and release.json in $SOURCE_DIR" >&2
  exit 1
fi

mkdir -p "$TARGET_ROOT"
rm -rf "$TARGET_DIR"
mkdir -p "$TARGET_DIR"
cp "$SOURCE_DIR/pet.json" "$TARGET_DIR/pet.json"
cp "$SOURCE_DIR/spritesheet.webp" "$TARGET_DIR/spritesheet.webp"

echo "Installed Joel-y release '$RELEASE_ID' from '$REF' to $TARGET_DIR"
echo "Restart Codex if Joel-y does not refresh immediately."
