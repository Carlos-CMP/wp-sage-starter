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

Copy `.env.example` to `.env` and fill the LocalWP database and URL values.

```powershell
.\new-project.ps1 -DbHost 127.0.0.1:10023
```

See `docs/SETUP.md` for the short local setup notes.

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
.\scripts\wp.ps1 --info
.\scripts\validate.ps1
```
