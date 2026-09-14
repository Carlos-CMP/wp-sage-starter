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
- Git

The scripts resolve these from PATH. If one isn't on PATH, or you need to pin a specific installation, set the matching environment variable to its executable path instead of editing any script: `STARTER_PHP`, `STARTER_COMPOSER`, `STARTER_WP_CLI`, `STARTER_GIT`, `STARTER_NODE`, `STARTER_NPM`.

## Setup

1. GitHub → **Use this template** (not `git clone`), then clone your new repository.
2. ```powershell
   .\scripts\doctor.ps1
   ```
3. ```powershell
   .\scripts\link-localwp.ps1 -LocalSitePath "$env:USERPROFILE\Local Sites\starter-sage-wp"
   ```
4. ```powershell
   .\new-project.ps1 -ProjectName "My Project" -Domain "my-project.local" -DbHost "127.0.0.1:10023"
   ```
   Use `-Domain "localhost:<port>"` in LocalWP's localhost Routing Mode. `.env` keys: see `.env.example`.
5. ```powershell
   .\scripts\validate.ps1
   ```

Other commands: `.\scripts\wp.ps1 --info` (WP-CLI), `.\scripts\seed-demo-content.ps1` (re-seed demo homepage).

## Architecture

https://carlos-cmp.github.io/wp-sage-starter/runtime-architecture/runtime-architecture.html
