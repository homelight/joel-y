# Joel-y

![Joel-y](source/pngs/joel-y-large-transparent.png)

Joel-y is a Codex custom pet asset package.

The repo keeps the installable Codex pet files alongside source PNG frames and reference artifacts so Joel-y can be updated over time with new primitives, outfits, expressions, and places.

## Repo Layout

- `pet/joel-y/`: Ready-to-install Codex pet package.
- `source/pngs/`: Editable/exported PNG frames used to build the pet.
- `artifacts/`: Review artifacts such as contact sheets.
- `docs/`: Notes for adding future variants.

## Install Locally

Copy the pet package into your Codex pets directory:

```bash
mkdir -p ~/.codex/pets
cp -R pet/joel-y ~/.codex/pets/
```

Restart Codex if the pet does not appear immediately.

## Current Pet Files

- `pet/joel-y/pet.json`: Codex pet metadata.
- `pet/joel-y/spritesheet.webp`: Animated pet atlas.

## Updating Joel-y

When adding new primitives, outfits, or places:

1. Add or update source frames under `source/pngs/`.
2. Add a short note under `docs/variants.md`.
3. Regenerate `pet/joel-y/spritesheet.webp` and update `pet/joel-y/pet.json` if states or atlas dimensions change.
4. Refresh `artifacts/contact-sheet.png` for review.
5. Commit the source frames, generated pet files, and review artifact together.
