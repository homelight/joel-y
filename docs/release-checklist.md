# Joel-y Release Checklist

Use this checklist when publishing a Joel-y update.

## 1. Prepare The Update

- Add or update source frames under `source/pngs/`.
- For any outfit, place, or primitive variant, regenerate `pet/joel-y/spritesheet.webp`.
- Update `pet/joel-y/pet.json` if the pet metadata changes.
- Refresh `artifacts/contact-sheet.png`.
- Create an immutable versioned release under `releases/<release-id>/` containing:
  - `pet.json`
  - `spritesheet.webp`
  - `contact-sheet.png`
  - `release.json`
- Update `releases/index.json` with the new release and set `latest` when it should become the default install.
- Update `docs/variants.md` with the new primitive, outfit, place, or behavior.
- Add a note to `CHANGELOG.md`.

## 2. Verify The Package

- Confirm `pet/joel-y/pet.json` exists.
- Confirm `pet/joel-y/spritesheet.webp` exists.
- Confirm `releases/<release-id>/pet.json` exists.
- Confirm `releases/<release-id>/spritesheet.webp` exists.
- Confirm `releases/<release-id>/contact-sheet.png` exists.
- Confirm `releases/<release-id>/release.json` exists.
- Run `scripts/verify-release.sh origin/main`.
- Run `scripts/install-or-update.sh`.
- Run `scripts/install-or-update.sh --release <release-id>`.
- Restart Codex and visually confirm Joel-y appears correctly.

## 3. Publish

```bash
git status
git add .
git commit -m "Update Joel-y <short description>"
git push -u origin <branch-name>
gh pr create --repo homelight/joel-y --base main --head <branch-name>
```

For bigger updates, add a tag:

```bash
git tag vYYYY.MM.DD-short-name
git push origin vYYYY.MM.DD-short-name
```

## 4. Announce

Copy `docs/templates/team-announcement.md`, fill in the summary, and send it to the team.
