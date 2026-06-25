#!/usr/bin/env bash
set -euo pipefail

BASE_REF="${1:-origin/main}"

if ! git rev-parse --verify "$BASE_REF" >/dev/null 2>&1; then
  echo "Base ref '$BASE_REF' does not exist. Fetch first or pass a valid ref." >&2
  exit 1
fi

changed_files="$(git diff --name-only "$BASE_REF"...HEAD)"

has_variant_change=false
has_spritesheet_change=false
has_contact_sheet_change=false
has_release_note=false

while IFS= read -r path; do
  [[ -z "$path" ]] && continue

  case "$path" in
    source/variants/*)
      has_variant_change=true
      ;;
    pet/joel-y/spritesheet.webp)
      has_spritesheet_change=true
      ;;
    artifacts/contact-sheet.png)
      has_contact_sheet_change=true
      ;;
    docs/releases/*|CHANGELOG.md|docs/variants.md)
      has_release_note=true
      ;;
  esac
done <<< "$changed_files"

if [[ "$has_variant_change" == true ]]; then
  missing=()
  [[ "$has_spritesheet_change" == false ]] && missing+=("pet/joel-y/spritesheet.webp")
  [[ "$has_contact_sheet_change" == false ]] && missing+=("artifacts/contact-sheet.png")
  [[ "$has_release_note" == false ]] && missing+=("docs/releases/*, CHANGELOG.md, or docs/variants.md")

  if (( ${#missing[@]} > 0 )); then
    echo "Variant changes require a complete pet release." >&2
    echo "Missing:" >&2
    for item in "${missing[@]}"; do
      echo "- $item" >&2
    done
    exit 1
  fi
fi

if [[ ! -f pet/joel-y/pet.json || ! -f pet/joel-y/spritesheet.webp ]]; then
  echo "Missing installable pet package files under pet/joel-y/." >&2
  exit 1
fi

echo "Joel-y release check passed."
