# Tasks: Starter foundation and design system

- [x] Verify toolchain paths: PHP 8.3, Composer, Node/npm, and WP-CLI.
- [x] Scaffold current stable Bedrock in the repository root.
- [x] Install current stable Sage as a Composer-managed theme.
- [x] Rename/configure the Sage theme as `starter-theme`.
- [x] Confirm `composer.json` and `composer.lock` pin the resolved Bedrock, WordPress, Sage, and PHP dependency versions.
- [x] Adapt `.env.example` with required non-secret environment variables and `STARTER_VERSION=1.0.0`.
- [x] Review `.gitignore` for `.env`, local uploads, dependencies, and generated build output.
- [x] Create minimal `README.md`.
- [x] Create initial `AGENTS.md`.
- [x] Create `CHANGELOG.md`.
- [x] Create short `docs/SETUP.md`.
- [x] Create short `docs/ARCHITECTURE.md`.
- [x] Add design-system files under `web/app/themes/starter-theme/resources/design-system/`.
- [x] Wire default tokens and project token overrides into Sage/Tailwind styling.
- [x] Add base typography, container/layout primitives, button styles, and basic form styles.
- [x] Create minimal `default`, `full-width`, and `landing` Blade layout wrappers.
- [x] Run `C:\php83\php.exe -v`.
- [x] Run `C:\php83\php.exe C:\ProgramData\ComposerSetup\bin\composer.phar install`.
- [x] Run `npm install` in the Sage theme.
- [x] Run `npm run build` in the Sage theme.
- [x] Run `C:\php83\php.exe C:\wp-cli\wp-cli.phar --info`.
- [x] Check whether `.env`/LocalWP values are available for basic WordPress/Sage boot readiness.
- [x] Record any boot-readiness blocker instead of marking boot validation passed without a local runtime.

Boot-readiness note: `.env` is not present, so real WordPress/Sage boot is blocked until LocalWP database and URL values are copied from `.env.example` into `.env`.

WP-CLI note: `scripts/wp.ps1` wraps `C:\php83\php.exe C:\wp-cli\wp-cli.phar` for consistent project usage.
