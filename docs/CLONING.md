# Cloning The Starter

This repository is meant to be cloned as the base for a new WordPress project. The generated project owns its future changes.

## Required Local Tools

The scripts resolve these from PATH — install them normally and there is nothing to configure:

- PHP >= 8.3
- Composer >= 2.x
- WP-CLI (the `wp` command)
- Git
- Node.js current LTS (and npm)
- LocalWP recommended

If a tool isn't on PATH, or you need to pin a specific installation, set the matching environment variable to its executable path instead of editing any script: `STARTER_PHP`, `STARTER_COMPOSER`, `STARTER_WP_CLI`, `STARTER_GIT`, `STARTER_NODE`, `STARTER_NPM`.

Check the machine before bootstrapping:

```powershell
.\scripts\doctor.ps1
```

## Detach From The Starter

Right after cloning, before running anything else, turn the clone into an independent project:

```powershell
.\scripts\new-instance.ps1
```

This removes `docs/planning` (the starter's own internal build docs, not relevant to a client project) and resets git history to a single commit with no starter remote attached, so the new project owns its history from commit 1. It asks for confirmation and requires a clean working tree; pass `-Force` to skip the prompt, or `-KeepPlanningDocs` to keep the planning docs.

## LocalWP Flow

1. Create a new site in LocalWP.
2. Use the project name as the LocalWP site domain when possible.
3. Clone this repository outside or inside `~/Local Sites`, then run `.\scripts\new-instance.ps1` as described above.
4. Link LocalWP's `app/public` directory to the starter `web` directory:

```powershell
.\scripts\link-localwp.ps1 -LocalSitePath "$env:USERPROFILE\Local Sites\starter-sage-wp"
```

The script moves the existing LocalWP `app/public` directory to a timestamped backup and creates a junction to this repository's `web` directory.

## Bootstrap

Use the DB host and frontend URL shown by LocalWP.

Site Domains mode:

```powershell
.\new-project.ps1 -ProjectName "My Project" -Domain "my-project.local" -DbHost "127.0.0.1:10023"
```

Localhost Routing Mode:

```powershell
.\new-project.ps1 -ProjectName "My Project" -Domain "localhost:10022" -DbHost "127.0.0.1:10023"
```

The script creates `.env` when missing, installs dependencies, builds the theme, activates the starter plugin/theme, configures permalinks, and seeds the starter pages.

## After Bootstrap

Validate the project:

```powershell
.\scripts\validate.ps1
```

Then open the frontend URL configured in `.env`.
