# Changelog

## Unreleased

- Bootstrap scripts (`doctor.ps1`, `new-project.ps1`, `validate.ps1`, `wp.ps1`) now resolve PHP, Composer, Node, npm, WP-CLI, and Git from PATH instead of hardcoded machine-specific paths, with optional `STARTER_*` environment variable overrides.
- Added `scripts/new-instance.ps1` to detach a fresh clone from the starter: drops `docs/planning` and resets git history to a single commit with no starter remote.
- Fixed `doctor.ps1` crashing instead of reporting a clean error when an invoked tool (e.g. WP-CLI) fails.
- `new-project.ps1` now checks `wp core is-installed` before activating the plugin/theme, and checks the exit code of every WP-CLI call, instead of silently reporting "Bootstrap complete" after a failed step.
- `scripts/seed-demo-content.ps1` now seeds a single Hero block on the `Starter Components` homepage instead of one of each starter block.

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
