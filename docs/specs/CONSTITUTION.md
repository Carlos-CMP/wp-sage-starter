# Constitution

## Goal

Build a reusable WordPress starter for real marketing websites. It is a template of origin: generated projects evolve independently and are not synchronized back from the starter.

## Stack

- WordPress on Bedrock.
- Sage theme.
- Tailwind CSS.
- Gutenberg editor.
- ACF Free only.
- PHP >= 8.3.
- Composer >= 2.x.
- Node.js current LTS.
- WP-CLI for bootstrap automation.
- LocalWP is the recommended local reference environment; native/manual setup remains supported.
- GitHub Actions for minimal validation CI.

## Architecture

- Bedrock owns environment configuration, dependency management, and WordPress bootstrap.
- Sage owns presentation: Blade templates, Gutenberg block rendering, Tailwind, navigation, and visual components.
- `site-content` owns content/domain configuration: CPTs, taxonomies, ACF field registration where allowed, site settings, feature flags, hooks, filters, and reusable content behavior.
- Theme code must not contain project content models that belong in `site-content`.
- `site-content` must not depend on theme-specific markup or styling.
- Secrets and environment values belong in `.env`.
- Non-sensitive project behavior belongs in project config and versioned feature flags.

## Block Conventions

- Blocks are modular and self-contained.
- A block folder owns its metadata, optional simple ACF Free fields, render/data preparation, Blade component, and short README.
- Do not use ACF Pro-only APIs, ACF Blocks, repeaters, flexible content, clone fields, or Options Pages.
- Use native Gutenberg attributes and `InnerBlocks` for repeated or nested block content.
- Do not put business logic in Blade.
- Do not mix ACF registration with markup.
- Components consume design tokens and must not hardcode project branding.
- Blocks must be independently removable.

## Design System

- Ship a minimal neutral default design system.
- Centralize colors, typography, spacing, container widths, breakpoints, radius, shadows, and z-index.
- Projects replace tokens/configuration, not component internals.
- Branding must be replaceable without editing block markup.

## Runtime And Versions

- Resolve WordPress, Bedrock, Sage, PHP package, and Node package versions when creating `v1.0.0`.
- Commit generated lock files.
- Do not rely on broad dependency ranges as the only reproducibility mechanism.

## Local Development

- LocalWP is recommended, but the starter must not depend on LocalWP internals.
- Database credentials, URL, and paths come from `.env`.
- Bootstrap scripts must fail early and clearly when required tools are missing.
- Re-running bootstrap must not corrupt an existing local setup.

## Security

- Never commit secrets.
- Sanitize input.
- Escape output.
- Use WordPress nonces and capabilities for state-changing or privileged behavior.
- Production must not expose debug information.
- Do not install a security plugin by default.

## Dependencies

- Keep the plugin footprint minimal.
- ACF Free is the only required content-field plugin.
- Additional plugins require a concrete project need.
- Do not install SEO, security, caching, forms, analytics, cookie, or multilingual plugins by default.
- Docker is not part of `v1.0.0`; consider it only if a concrete project need appears.

## Quality

- `v1.0.0` quality tooling is PHPCS with minimal WordPress-compatible rules, ESLint, and Prettier.
- `v1.0.0` validation is lint, successful Sage asset build, bootstrap smoke validation, and minimal CI.
- PHPUnit and E2E are optional later work, not mandatory for `v1.0.0`.
- Do not add more quality tools without a concrete failure they solve.

## Documentation

- Required docs are `README.md`, `AGENTS.md`, `CHANGELOG.md`, `docs/SETUP.md`, and `docs/ARCHITECTURE.md`.
- Keep docs short and operational.
- Prefer links over repeated guidance.

## Non-Goals

- ACF Pro.
- Page builders.
- Automatic starter upgrades.
- Redis, Varnish, cache plugins, or custom cache layers by default.
- Provider-specific analytics, SEO, forms, cookies, multilingual, or deployment integrations by default.
- Form submission storage by default.
- Generic external API framework.
- Project-specific CPTs, taxonomies, or business logic.
- Mandatory Docker.
- Heavy automated test suites.
