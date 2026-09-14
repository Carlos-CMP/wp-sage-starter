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

1. Create a new repository from this starter using GitHub's **Use this template** button (not `git clone` — that keeps the starter's own history and `origin`), then clone your new repository.
2. Remove the starter's own internal planning docs (not relevant to your project):

   ```powershell
   .\scripts\new-instance.ps1
   ```

   Asks for confirmation; pass `-Force` to skip it. A no-op if `docs/planning` is already gone.
3. Check your machine against the requirements above:

   ```powershell
   .\scripts\doctor.ps1
   ```
4. Create a LocalWP site with WordPress installed, then link its `app/public` to this repository's `web` directory (moves the existing `app/public` to a timestamped backup and creates a junction):

   ```powershell
   .\scripts\link-localwp.ps1 -LocalSitePath "$env:USERPROFILE\Local Sites\starter-sage-wp"
   ```
5. Bootstrap, using the DB host and frontend URL shown by LocalWP:

   ```powershell
   .\new-project.ps1 -ProjectName "My Project" -Domain "my-project.local" -DbHost "127.0.0.1:10023"
   ```

   Use `-Domain "localhost:<port>"` when LocalWP is in localhost Routing Mode. This creates `.env` when missing (holding `DB_NAME`, `DB_USER`, `DB_PASSWORD`, `DB_HOST`, `WP_HOME`, `WP_SITEURL`, and the WordPress salts — keep it out of version control), installs dependencies, builds the theme, activates the starter plugin/theme, configures permalinks, and seeds the `Starter Components` homepage.
6. Validate:

   ```powershell
   .\scripts\validate.ps1
   ```

To run WP-CLI directly: `.\scripts\wp.ps1 --info` (commands that load WordPress require `.env` with LocalWP database and URL values). To re-seed the demo homepage later without re-running the full bootstrap: `.\scripts\seed-demo-content.ps1`.

## Architecture

Bedrock, Sage, and `site-content` each own a boundary of the stack — see `AGENTS.md` for the rules.

See `docs/BLOCKS.md` to add blocks.
See `AGENTS.md` for the coding conventions AI agents and contributors must follow: architecture, design tokens, feature flags, menus, hooks, and cross-cutting accessibility, performance, SEO, analytics, forms, logging, and security rules.
See `docs/runtime-architecture.html` for an interactive runtime diagram.
