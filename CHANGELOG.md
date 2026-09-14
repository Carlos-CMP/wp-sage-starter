# Changelog

## Unreleased

- Bootstrap scripts (`doctor.ps1`, `new-project.ps1`, `validate.ps1`, `wp.ps1`) now resolve PHP, Composer, Node, npm, WP-CLI, and Git from PATH instead of hardcoded machine-specific paths, with optional `STARTER_*` environment variable overrides.
- Fixed `doctor.ps1` crashing instead of reporting a clean error when an invoked tool (e.g. WP-CLI) fails.

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
