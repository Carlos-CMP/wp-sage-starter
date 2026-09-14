# Changelog

## Unreleased

- Bootstrap scripts (`doctor.ps1`, `new-project.ps1`, `validate.ps1`, `wp.ps1`) now resolve PHP, Composer, Node, npm, WP-CLI, and Git from PATH instead of hardcoded machine-specific paths, with optional `STARTER_*` environment variable overrides.
- The starter repository on GitHub is now a template repository. New projects are created with **Use this template**, which starts the new repository with a single commit and no `origin` pointing back to the starter — `git clone` should no longer be used to start a new project.
- `scripts/new-instance.ps1` no longer touches git history or remotes (GitHub's template feature handles that); it now only drops `docs/planning` from a freshly created project.
- Fixed `doctor.ps1` crashing instead of reporting a clean error when an invoked tool (e.g. WP-CLI) fails.
- `new-project.ps1` now checks `wp core is-installed` before activating the plugin/theme, and checks the exit code of every WP-CLI call, instead of silently reporting "Bootstrap complete" after a failed step.
- `scripts/seed-demo-content.ps1` now seeds a single Hero block on the `Starter Components` homepage instead of one of each starter block.
- PHP and Node version requirements are now enforced by Composer and npm themselves instead of custom checks in `doctor.ps1`: removed `"platform-check": false` from `composer.json` (Composer now enforces `"php": ">=8.3"` natively), and added `web/app/themes/starter-theme/.npmrc` with `engine-strict=true` (npm now enforces the theme's `package.json` `engines.node`). `doctor.ps1` still reports the detected versions but no longer duplicates the range checks.

## 1.0.0 - 2026-09-10

- Initial Bedrock and Sage starter foundation.
- Minimal replaceable design-system layer.
- First-party `site-content` plugin for settings, feature flags, hooks, and content/domain boundaries.
- Native Gutenberg blocks: Hero, Text + Image, CTA, Accordion / FAQ.
- Generic header, footer, menus, and base templates.
- Local bootstrap, WP-CLI wrapper, demo seed, and validation scripts.
- Minimal cross-cutting baseline for accessibility, performance, SEO compatibility, analytics hooks, forms, logging, and security.
- GitHub Actions validation workflow.
- Short operational documentation.
