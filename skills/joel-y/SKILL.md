---
name: joel-y
description: Install, update, or switch the Joel-y Codex custom pet from the HomeLight `homelight/joel-y` repository. Use when a user asks to update Joel-y in Codex, install Joel-y, pull the latest Joel-y pet, switch to a specific Joel-y release/tag/commit, select an outfit/vibe release, or verify which Joel-y version is installed.
---

# Joel-y

## Overview

Use this skill to install or update the Joel-y Codex pet from the shared HomeLight repo. Prefer the bundled script so installs are consistent across users.

## Quick Commands

From any checkout of `homelight/joel-y`:

```bash
./skills/joel-y/scripts/update-joel-y.sh --latest
```

Install a specific release, tag, branch, or commit:

```bash
./skills/joel-y/scripts/update-joel-y.sh --ref <release-tag-or-sha>
```

List available version refs:

```bash
./skills/joel-y/scripts/update-joel-y.sh --list
```

Show the installed pet metadata:

```bash
./skills/joel-y/scripts/update-joel-y.sh --status
```

## Workflow

1. If the user has a local `homelight/joel-y` checkout, run commands from that repo.
2. If the user does not have a checkout, use the script's `--repo-dir <path>` option or let it clone into `${CODEX_HOME:-$HOME/.codex}/joel-y-repo`.
3. Use `--latest` for the current `main`.
4. Use `--ref <tag|branch|sha>` when the user asks for a specific outfit, vibe, or release.
5. After install, tell the user to restart Codex if Joel-y does not refresh immediately.

## Release Expectations

Released Joel-y variants must include an updated `pet/joel-y/spritesheet.webp`. Do not describe a source-only variant under `source/variants/` as installable unless the active spritesheet was regenerated for that release.

If a user wants a source-only variant made active, create a normal PR that regenerates the full pet package first. Do not push directly to `main`.

## Script Notes

The update script copies:

- `pet/joel-y/pet.json`
- `pet/joel-y/spritesheet.webp`

into:

```text
${CODEX_HOME:-$HOME/.codex}/pets/joel-y/
```

The repo installer can also copy this skill into:

```text
${CODEX_HOME:-$HOME/.codex}/skills/joel-y/
```
