# Proposal: Starter foundation and design system

## Intent

Create the first usable foundation for the WordPress Sage starter. This milestone establishes the project base, runtime constraints, reproducible dependency locks, minimal documentation, and the replaceable design-system layer needed before any block work begins.

This corresponds to the plan's first harness milestone: Phase 0, Foundation Decisions, plus Phase 1, Theme and Design System.

## Scope

### In scope

- Bedrock project foundation using the current stable release compatible with PHP >= 8.3.
- Sage theme installed as the starter theme.
- Resolved dependency versions committed through lock files.
- Root structure aligned with the starter plan.
- `.env.example` with required non-secret local/staging/production variables.
- Starter version recorded for `v1.0.0`.
- Minimal `README.md`.
- Initial `AGENTS.md` with architecture, block, content, security, and harness rules.
- Tailwind configured inside the Sage theme.
- Minimal neutral design tokens.
- Project token override layer.
- Base typography, container/layout primitives, button styles, and basic form styles.
- Minimal `default`, `full-width`, and `landing` Blade layout wrappers.
- Validation commands for Composer install, npm install, Sage build, and basic WordPress/Sage boot.

### Out of scope

- `site-content` plugin implementation.
- Gutenberg block infrastructure.
- The 4 `v1.0.0` blocks.
- Header, navigation, footer, and system templates.
- Demo/showcase and seed data.
- Bootstrap automation script.
- Docker.
- Deployment automation or artifact packaging.
- PHPUnit or E2E setup.
- SEO, analytics, forms, or multilingual integrations beyond preserving compatibility in foundation choices.

## Acceptance

- Composer dependencies install with PHP >= 8.3.
- Bedrock boots locally once `.env` points at a prepared local database/site.
- Sage dependencies install.
- Sage assets build successfully.
- Tailwind consumes default tokens and supports project-level overrides.
- The three minimal layouts exist and do not contain project-specific assumptions.
- Secrets are excluded from version control.
- Initial docs explain only how to bootstrap, where code belongs, how configuration works, and how to validate the milestone.

## Decisions Made

- WP-CLI is installed globally at `C:\wp-cli\wp-cli.phar`. The implementation may use this path directly or expose it through a documented wrapper/configuration; it must not depend on LocalWP internals for WP-CLI.
- Clean all pre-SDD implementation artifacts and start the implementation from zero. Done: the workspace now preserves only planning/runtime context (`docs/`, `specs/`, and `.pastiche/`).
- PHP 8.3 is installed at `C:\php83` and added to the user `PATH`. Composer can run with PHP 8.3.33 from that path.
- WordPress `7.1` is accepted as the latest stable release resolved at implementation time and must be pinned by the generated lock file.
