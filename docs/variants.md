# Joel-y Variants

Use this file as the running index for future Joel-y updates.

## Baseline

- Default Joel-y Codex pet.
- Includes idle, thinking, waiting, running, jumping, waving, review, and failed states.

## Ideas

- Beach location.
- Seasonal outfits.
- HomeLight-themed accessories.
- Additional expressions and work states.

## Surfer — fresh rebuild

- Date: 2026-09-16
- Release: `surfer-2026-09-16`
- Source and build notes: `source/variants/surfer-2026-09-16/`
- Teal rash guard, coral shorts, expressive blue eyes, and yellow surfboard with attached blue wave.
- Full v2 package with nine animation states and sixteen clockwise looking directions; magenta background extraction preserves the teal/blue palette.
- Atlas and blind direction validation passed. Independent visual review accepted intermediate-angle and continuity warnings; live playback was not verified.
- Release notes: `docs/releases/2026-09-16-surfer.md`.

## Big Apple Vacation

- Date: 2026-07-31
- Release: `big-apple-vacation`
- Source: `source/variants/big-apple-vacation/joel-y-big-apple-vacation-base-transparent.png`
- Raw chroma source: `source/variants/big-apple-vacation/joel-y-big-apple-vacation-base-chroma.png`
- Notes: New York city-week variant with a navy jacket, clear eyes, a bright yellow taxi-shaped shoulder bag, and a bold checker stripe. The v2 atlas includes the nine standard states plus 16 looking directions.
- Visual acceptance: the taxi bag and checker stripe must be visibly attached and readable in the generated spritesheet and contact sheet; the navy jacket and clear eyes must remain present; `000` is up, `090` is screen-right, `180` is down, and `270` is screen-left. No text, logos, skyline, or scenery are required.
- QA: `artifacts/contact-sheet.png` and `artifacts/big-apple-vacation-look-directions.png` were visually reviewed; independent blind direction review passed the cardinal gates and all 16 semantics were resolved as pass.

## Golf Outfit

- Date: 2026-06-25
- Source: `source/variants/golf/joel-y-golf-transparent.png`
- Raw chroma source: `source/variants/golf/joel-y-golf-chroma.png`
- Notes: Keeps Joel-y's blond hair, sunglasses, face, and sticker-like illustration style while swapping in a clean golf polo, vest, glove, golf shoes, and club.
- Next step: Use this as the identity reference for a full golf-course or golf-outfit animated atlas if we want Codex to run the golf Joel-y variant as the active pet.

## Birthday

- Date: 2026-06-26
- Source: `source/variants/birthday/joel-y-birthday-pose-sheet.png`
- Idle source: `source/variants/birthday/joel-y-birthday-transparent.png`
- Raw chroma source: `source/variants/birthday/joel-y-birthday-chroma.png`
- Release: `birthday-2026-06-26`
- Notes: New standalone Joel-y birthday artwork with a turquoise Hawaiian shirt, floral print, sunglasses, white sneakers, and birthday hat. This variant uses distinct source poses for the idle, running, waving, jumping, failed, waiting, sprinting, and review primitives rather than repeating a single standing pose.

## Variant Checklist

- Keep the recognizable Joel-y silhouette consistent.
- Use transparent backgrounds unless the variant is intentionally location-based.
- Match existing frame dimensions and alignment where possible.
- Update `pet/joel-y/pet.json` only when the generated atlas contract changes.
- Refresh `artifacts/contact-sheet.png` after generating new frames.
