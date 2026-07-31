# Joel-y Big Apple Vacation

Release id: `big-apple-vacation`

Adds a New York city-week Joel-y variant with a navy jacket, clear eyes, and a bright yellow taxi-shaped shoulder bag with a bold checker stripe. The v2 atlas contains the nine standard animation states plus 16 explicit looking directions.

Visual acceptance criteria:

- The yellow taxi-shaped shoulder bag remains visibly attached across the generated spritesheet and contact sheet.
- The bag's bold checker stripe remains readable at 192x208 pet size.
- The navy jacket and clear eyes remain visible in the final atlas.
- Look direction semantics are consistent: `000` up, `090` screen-right, `180` down, and `270` screen-left.
- The 16-direction loop is coherent without requiring text, logos, skyline, or scenery.

Package files:

- `releases/big-apple-vacation/pet.json`
- `releases/big-apple-vacation/spritesheet.webp`
- `releases/big-apple-vacation/contact-sheet.png`
- `releases/big-apple-vacation/release.json`

Review artifacts:

- `artifacts/contact-sheet.png`
- `artifacts/big-apple-vacation-look-directions.png`

Verification:

```bash
./scripts/verify-release.sh origin/main
./scripts/install-or-update.sh --list
./scripts/install-or-update.sh --release big-apple-vacation
./scripts/install-or-update.sh --latest
```

Install this release after it is merged with:

```bash
./scripts/install-or-update.sh --release big-apple-vacation
```
