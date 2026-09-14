# Starting A Project From The Starter

This repository is a GitHub template repository, meant as the base for a new WordPress project. The generated project owns its future changes.

This starter targets Windows + LocalWP only. The bootstrap scripts are PowerShell and `scripts/link-localwp.ps1` relies on Windows-only NTFS junctions — there is no macOS/Linux or non-LocalWP setup path.

## Create The Project Repository

Use GitHub's **Use this template** button on the starter repository, not `git clone`. This creates a new repository with a single commit and no `origin` pointing back to the starter, so the new project owns its history from commit 1 with no risk of pushing project-specific commits back into the shared starter.

Then clone your new repository as usual.

## Remove The Starter's Planning Docs

Right after cloning your new repository, remove the starter's own internal build/planning docs (not relevant to a client project):

```powershell
.\scripts\new-instance.ps1
```

It asks for confirmation; pass `-Force` to skip the prompt. If `docs/planning` is already gone, it's a no-op.

## Required Local Tools

The scripts resolve these from PATH — install them normally and there is nothing to configure:

- Windows
- LocalWP, with WordPress already installed on the site you create
- PHP >= 8.3
- Composer >= 2.x
- WP-CLI (the `wp` command)
- Git
- Node.js (and npm) matching `web/app/themes/starter-theme/package.json` engines (currently `^20.19.0` or `>=22.12.0`)

If a tool isn't on PATH, or you need to pin a specific installation, set the matching environment variable to its executable path instead of editing any script: `STARTER_PHP`, `STARTER_COMPOSER`, `STARTER_WP_CLI`, `STARTER_GIT`, `STARTER_NODE`, `STARTER_NPM`.

Check the machine before bootstrapping:

```powershell
.\scripts\doctor.ps1
```

## LocalWP Flow

1. Create a new site in LocalWP (see "Create The Project Repository" and "Remove The Starter's Planning Docs" above if you haven't already).
2. Use the project name as the LocalWP site domain when possible.
3. Link LocalWP's `app/public` directory to your project's `web` directory:

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

`.env` holds `DB_NAME`, `DB_USER`, `DB_PASSWORD`, `DB_HOST`, `WP_HOME`, `WP_SITEURL`, and the WordPress salts. Keep it out of version control.

## WP-CLI

```powershell
.\scripts\wp.ps1 --info
```

Commands that load WordPress require `.env` with LocalWP database and URL values.

## Re-seeding Demo Content

Bootstrap already seeds the `Starter Components` homepage. To reseed it later without re-running the full bootstrap:

```powershell
.\scripts\seed-demo-content.ps1
```

## After Bootstrap

Validate the project:

```powershell
.\scripts\validate.ps1
```

Then open the frontend URL configured in `.env`.
