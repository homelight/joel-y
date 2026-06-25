# Joel-y Release Checklist

Use this checklist when publishing a Joel-y update.

## 1. Prepare The Update

- Add or update source frames under `source/pngs/`.
- Regenerate `pet/joel-y/spritesheet.webp`.
- Update `pet/joel-y/pet.json` if the pet metadata changes.
- Refresh `artifacts/contact-sheet.png`.
- Update `docs/variants.md` with the new primitive, outfit, place, or behavior.
- Add a note to `CHANGELOG.md`.

## 2. Verify The Package

- Confirm `pet/joel-y/pet.json` exists.
- Confirm `pet/joel-y/spritesheet.webp` exists.
- Run `scripts/install-or-update.sh`.
- Restart Codex and visually confirm Joel-y appears correctly.

## 3. Publish

```bash
git status
git add .
git commit -m "Update Joel-y <short description>"
git push
```

For bigger updates, add a tag:

```bash
git tag vYYYY.MM.DD-short-name
git push origin vYYYY.MM.DD-short-name
```

## 4. Announce

Copy `docs/templates/team-announcement.md`, fill in the summary, and send it to the team.
