# Design: Starter foundation and design system

## Approach

Build the foundation from a clean workspace using the approved stack and constitution:

1. Scaffold current stable Bedrock with Composer running on PHP 8.3.
2. Install Sage as the starter theme through Composer.
3. Rename/configure the installed theme as `starter-theme`.
4. Add minimal project-level files required by the constitution.
5. Configure the Sage/Tailwind design-system layer before any block work.
6. Validate only the first milestone: Composer install, npm install, Sage build, and basic WordPress/Sage boot readiness.

Implementation must stop after Phase 0 and Phase 1 validation.

## Environment Assumptions

- PHP 8.3 is available at `C:\php83\php.exe` and on the user `PATH`.
- Composer is available through `C:\ProgramData\ComposerSetup\bin\composer.phar`.
- WP-CLI is available at `C:\wp-cli\wp-cli.phar`.
- LocalWP provides the local database/site runtime; the starter reads connection values from `.env`.
- The workspace starts from planning files only: `docs/`, `specs/`, and `.pastiche/`.

## Foundation

Use Composer to create the Bedrock project in the repository root, not in a nested final directory.

Expected resolved baseline:

- `roots/bedrock` current stable.
- `roots/wordpress` latest stable resolved at implementation time, currently accepted as `7.1`.
- `roots/sage` current stable resolved at implementation time.
- PHP package versions recorded in `composer.lock`.

After scaffold:

- Keep Bedrock's `config/`, `web/`, `composer.json`, `composer.lock`, `wp-cli.yml`, and `.env.example`.
- Add or adapt root `README.md`, `AGENTS.md`, and `CHANGELOG.md`.
- Add `STARTER_VERSION=1.0.0` to `.env.example`.
- Ensure `.gitignore` excludes `.env`, local uploads, dependency folders where appropriate, and generated build output according to Bedrock/Sage conventions.

## Sage Theme

Install Sage as a Composer dependency and place it under:

```text
web/app/themes/starter-theme/
```

If Composer installs Sage under its package name, rename only the theme folder and update theme metadata/package names needed for local consistency.

Keep Sage's native structure unless the starter plan requires a small addition. Do not restructure Sage aggressively during this milestone.

## Design System

Add a minimal replaceable design-system layer inside the Sage theme:

```text
web/app/themes/starter-theme/resources/design-system/
|- tokens.css
|- project-tokens.css
|- typography.css
|- utilities.css
`- README.md
```

Token rules:

- `tokens.css` defines neutral defaults.
- `project-tokens.css` is the intended override surface for generated projects.
- Tailwind config exposes the same token concepts.
- Components/layouts consume tokens rather than hardcoded project branding.

Initial styling should cover:

- typography base
- container/layout primitives
- buttons
- basic form controls

## Layouts

Create or adapt minimal Blade wrappers for:

```text
default
full-width
landing
```

These layouts must:

- avoid project-specific content assumptions
- avoid advanced layout abstractions
- remain usable before header/footer/navigation are implemented in later phases
- not make blocks depend on a single layout

## Documentation

Keep docs short and operational:

- `README.md`: bootstrap commands, local environment expectation, validation commands.
- `AGENTS.md`: architecture rules, block rules, content rules, security rules, harness rules.
- `CHANGELOG.md`: initial unreleased/`1.0.0` entry.
- `docs/SETUP.md`: LocalWP/`.env` requirements and validation.
- `docs/ARCHITECTURE.md`: Bedrock/Sage/`site-content` boundaries and design-system override rule.

Do not duplicate the full implementation plan in these files.

## Validation

Run validation in this order:

```powershell
C:\php83\php.exe -v
C:\php83\php.exe C:\ProgramData\ComposerSetup\bin\composer.phar install
npm install
npm run build
C:\php83\php.exe C:\wp-cli\wp-cli.phar --info
```

For boot readiness:

- Confirm Bedrock can load configuration with a populated `.env`.
- If no LocalWP site/database is connected yet, record boot validation as blocked by missing local runtime values, not as passed.

## Affected Files

Expected new or generated paths:

- `composer.json`
- `composer.lock`
- `.env.example`
- `.gitignore`
- `wp-cli.yml`
- `README.md`
- `AGENTS.md`
- `CHANGELOG.md`
- `docs/SETUP.md`
- `docs/ARCHITECTURE.md`
- `config/**`
- `web/**`
- `web/app/themes/starter-theme/**`

Planning files remain:

- `specs/CONSTITUTION.md`
- `specs/starter-foundation-design-system/proposal.md`
- `specs/starter-foundation-design-system/design.md`

## Out Of Scope For This Design

- `site-content` plugin.
- Gutenberg block registration.
- Any `v1.0.0` block implementation.
- Header/navigation/footer.
- System templates.
- Demo/showcase.
- Bootstrap automation script.
- Docker.
- Deployment packaging.
- PHPUnit/E2E setup.

## Tradeoffs

### Use PHP 8.3 instead of PHP 8.2

Chosen because current Bedrock requires PHP 8.3. This keeps the starter on the current Roots stack instead of pinning an older Bedrock release.

### Keep Sage structure mostly intact

Chosen to reduce maintenance risk. The starter adds project conventions around Sage instead of rewriting Sage internals during the first milestone.

### Design tokens as CSS plus Tailwind mapping

Chosen because CSS tokens are easy for generated projects to override, while Tailwind mapping keeps component classes consistent.

### No local PHP binary in repo

Chosen because runtime tools belong to the development environment, not the starter source.

### Boot validation may be conditional

Chosen because LocalWP owns the actual local database/runtime. The milestone can verify tooling and build deterministically, but real WordPress boot requires `.env` values for a prepared local site.
