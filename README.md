# WordPress Sage Starter

Reusable WordPress starter for marketing websites, built with Bedrock, Sage, Tailwind CSS, Gutenberg, and ACF Free.

This starter is a template of origin. Generated projects evolve independently.

## Requirements

This starter targets Windows + LocalWP. The bootstrap scripts are PowerShell (`.ps1`) and `scripts/link-localwp.ps1` relies on Windows-only NTFS junctions — there is no macOS/Linux or non-LocalWP setup path.

- Windows
- LocalWP, with WordPress already installed on the site you create
- PHP >= 8.3
- Composer >= 2.x
- Node.js matching `web/app/themes/starter-theme/package.json` engines (currently `^20.19.0` or `>=22.12.0`)
- WP-CLI available on PATH

## Setup

Create a new repository from this starter using GitHub's **Use this template** button (not `git clone` — that keeps the starter's own history and `origin`). Then create a LocalWP site, link its `app/public` to your new repository's `web` directory, and bootstrap.

```powershell
.\scripts\new-instance.ps1
.\scripts\doctor.ps1
.\scripts\link-localwp.ps1 -LocalSitePath "$env:USERPROFILE\Local Sites\starter-sage-wp"
.\new-project.ps1 -ProjectName "My Project" -Domain "my-project.local" -DbHost "127.0.0.1:10023"
```

Use `-Domain "localhost:<port>"` when LocalWP is in localhost Routing Mode.

See `docs/CLONING.md` for the full template-to-bootstrap workflow.

## Architecture

- Bedrock: WordPress bootstrap, dependencies, environment config.
- Sage: presentation, Blade, Tailwind, Gutenberg rendering.
- `site-content`: future content/domain configuration boundary.

See `docs/ARCHITECTURE.md`.
See `docs/BLOCKS.md` to add blocks.
See `docs/PROJECT-CONFIG.md` for environment, tokens, feature flags, menus, and hooks.
See `AGENTS.md` for the coding conventions AI agents and contributors must follow, including cross-cutting accessibility, performance, SEO, analytics, forms, logging, and security rules.

## Validation

```powershell
C:\php83\php.exe -v
.\scripts\doctor.ps1
.\scripts\wp.ps1 --info
.\scripts\validate.ps1
```
