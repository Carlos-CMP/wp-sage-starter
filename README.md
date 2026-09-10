# WordPress Sage Starter

Reusable WordPress starter for marketing websites, built with Bedrock, Sage, Tailwind CSS, Gutenberg, and ACF Free.

This starter is a template of origin. Generated projects evolve independently.

## Requirements

- PHP >= 8.3
- Composer >= 2.x
- Node.js current LTS
- WP-CLI
- LocalWP recommended for local runtime

## Setup

Create a LocalWP site, clone the repository, link LocalWP's `app/public` to this starter's `web` directory, then bootstrap.

```powershell
.\scripts\doctor.ps1
.\scripts\link-localwp.ps1 -LocalSitePath "$env:USERPROFILE\Local Sites\starter-sage-wp"
.\new-project.ps1 -ProjectName "My Project" -Domain "my-project.local" -DbHost "127.0.0.1:10023"
```

Use `-Domain "localhost:<port>"` when LocalWP is in localhost Routing Mode.

See `docs/CLONING.md` for the clone-first workflow and `docs/SETUP.md` for local setup notes.

## Architecture

- Bedrock: WordPress bootstrap, dependencies, environment config.
- Sage: presentation, Blade, Tailwind, Gutenberg rendering.
- `site-content`: future content/domain configuration boundary.

See `docs/ARCHITECTURE.md`.
See `docs/BASELINE.md` for cross-cutting accessibility, performance, SEO, analytics, forms, logging, and security conventions.
See `docs/BLOCKS.md` to add blocks.
See `docs/PROJECT-CONFIG.md` for environment, tokens, feature flags, menus, and hooks.

## Validation

```powershell
C:\php83\php.exe -v
.\scripts\doctor.ps1
.\scripts\wp.ps1 --info
.\scripts\validate.ps1
```
