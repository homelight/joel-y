# Surfer Joel-y source provenance

Fresh built-in imagegen artwork created in Astra Medium on 2026-09-16 from the original Joel-y identity reference. No abandoned surfer repair assets were reused. Canonical artwork is `base.png`; all generated rows attach that reference. `running-left.png` is a framewise mirror of `running-right.png`, preserving time order. The board has no text or handed markings.

Background: #FF00FF magenta, separate from teal clothing, coral-orange shorts, yellow board, and blue wave. Original strips are kept at generated resolution. High-resolution source is downsampled once per extraction; enlarging small sprites was not used.

Processing uses the installed hatch-pet scripts and bundled Python/Pillow. Run `extract_strip_frames.py` with `--method auto` and magenta key for standard rows; use `--method stable-slots` for jumping to preserve its vertical arc and shared scale. Compose rows 0–8 with `compose_atlas.py`. Register look row 9 against idle frame 00 using `assemble_extended_atlas.py --registered-row-output`; assemble row 10 with the persisted row-9 registration. Apply `despill_chroma_edges.py` exactly once to the complete atlas and validate with `validate_atlas.py --require-v2`.

The assembler includes a dedicated neutral-look frame at row 0, column 6. All other unused cells are transparent. Final cells are 192×208; atlas is 1536×2288.

One left cardinal anchor was regenerated after the first strip pointed right. This corrected reference guided the full coherent second look row; no individually generated repair cells were inserted into the final look atlas. Thirteen successful image generations total: base, eight standard rows, cardinal strip, one cardinal correction, two look rows. One reference-count rejection occurred before image generation and was resolved by omitting the redundant original identity reference from row 10 (canonical surfer retained).

Prompts and job manifest document intended generation. Paths in the original run manifest describe the temporary build layout; source images are archived here by their decoded filenames. QA reports and motion previews ship with the release.
