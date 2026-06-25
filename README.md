# Joel-y

<img src="source/pngs/joel-y-large-transparent.png" alt="Joel-y" width="220">

Joel-y is a Codex custom pet asset package.

The repo keeps the installable Codex pet files alongside source PNG frames and reference artifacts so Joel-y can be updated over time with new primitives, outfits, expressions, and places.

## Active Pet

<img src="source/variants/golf/joel-y-golf-transparent.png" alt="Joel-y golf outfit" width="220">

- Active installable pet: golf outfit Joel-y in `pet/joel-y/spritesheet.webp`
- Every outfit, place, or primitive variant must regenerate the active spritesheet before release.
- Release notes: `docs/releases/2026-06-25-golf-outfit.md`

## Install Or Update

Clone the repo once:

```bash
git clone https://github.com/homelight/joel-y.git
cd joel-y
./scripts/install-or-update.sh
```

After that, update Joel-y with:

```bash
cd joel-y
git pull
./scripts/install-or-update.sh --latest
```

This also installs the `$joel-y` Codex skill into `~/.codex/skills/joel-y`.

After installing the skill, you can ask Codex:

```text
Use $joel-y to update my Joel-y pet to the latest version.
Use $joel-y to switch Joel-y to <release-tag>.
```

List and install a specific local Joel-y release:

```bash
./scripts/install-or-update.sh --list
./scripts/install-or-update.sh --release baseline
./scripts/install-or-update.sh --release golf-2026-06-25
```

Restart Codex if Joel-y does not refresh immediately.

## Repo Layout

- `pet/joel-y/`: Ready-to-install Codex pet package.
- `releases/`: Immutable versioned Joel-y pet packages.
- `source/pngs/`: Editable/exported PNG frames used to build the pet.
- `artifacts/`: Review artifacts such as contact sheets.
- `docs/`: Notes for adding future variants.
- `scripts/`: Install and update helpers.
- `skills/joel-y/`: Codex skill for installing latest or specific Joel-y releases.

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

1. Add or update source frames under `source/pngs/` or `source/variants/`.
2. Add a short note under `docs/variants.md`.
3. Regenerate `pet/joel-y/spritesheet.webp`; this is required for every released variant.
4. Refresh `artifacts/contact-sheet.png` for review.
5. Update `CHANGELOG.md`.
6. Add an immutable release under `releases/<release-id>/` with `pet.json`, `spritesheet.webp`, `contact-sheet.png`, and `release.json`.
7. Update `releases/index.json`.
8. Run `scripts/verify-release.sh origin/main`.
9. Commit the source frames, generated pet files, versioned release package, and review artifact together.
10. Open a PR; do not push directly to `main`.
11. Send the team an update using `docs/templates/team-announcement.md` after merge.

For a step-by-step publishing flow, use `docs/release-checklist.md`.
