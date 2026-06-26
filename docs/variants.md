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

## Birthday Aloha

- Date: 2026-06-26
- Release id: `birthday-30`
- Source: `source/variants/birthday-30/joel-y-birthday-30-transparent.png`
- Raw chroma source: `source/variants/birthday-30/joel-y-birthday-30-chroma.png`
- Notes: Birthday-week Joel-y keeps the recognizable blond hair, sunglasses, face shape, and sticker-like style while adding a bright teal Hawaiian shirt with oversized flower shapes and a readable cone party hat.
- Visual acceptance: The Hawaiian shirt, large floral shirt shapes, and birthday party hat must remain visible in `pet/joel-y/spritesheet.webp` and `artifacts/contact-sheet.png`; tiny party props are intentionally omitted so the core cues stay readable at 192x208.

## Golf Outfit

- Date: 2026-06-25
- Source: `source/variants/golf/joel-y-golf-transparent.png`
- Raw chroma source: `source/variants/golf/joel-y-golf-chroma.png`
- Notes: Keeps Joel-y's blond hair, sunglasses, face, and sticker-like illustration style while swapping in a clean golf polo, vest, glove, golf shoes, and club.
- Next step: Use this as the identity reference for a full golf-course or golf-outfit animated atlas if we want Codex to run the golf Joel-y variant as the active pet.

## Variant Checklist

- Keep the recognizable Joel-y silhouette consistent.
- Use transparent backgrounds unless the variant is intentionally location-based.
- Match existing frame dimensions and alignment where possible.
- Update `pet/joel-y/pet.json` only when the generated atlas contract changes.
- Refresh `artifacts/contact-sheet.png` after generating new frames.
