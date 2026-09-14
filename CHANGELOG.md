# Changelog

## Unreleased

- Bootstrap scripts (`doctor.ps1`, `new-project.ps1`, `validate.ps1`, `wp.ps1`) now resolve PHP, Composer, Node, npm, WP-CLI, and Git from PATH instead of hardcoded machine-specific paths, with optional `STARTER_*` environment variable overrides.
- The starter repository on GitHub is now a template repository. New projects are created with **Use this template**, which starts the new repository with a single commit and no `origin` pointing back to the starter — `git clone` should no longer be used to start a new project.
- `scripts/new-instance.ps1` no longer touches git history or remotes (GitHub's template feature handles that); it now only drops `docs/planning` and `docs/specs` from a freshly created project.
- Fixed `doctor.ps1` crashing instead of reporting a clean error when an invoked tool (e.g. WP-CLI) fails.
- `new-project.ps1` now checks `wp core is-installed` before activating the plugin/theme, and checks the exit code of every WP-CLI call, instead of silently reporting "Bootstrap complete" after a failed step.
- `scripts/seed-demo-content.ps1` now seeds a single Hero block on the `Starter Components` homepage instead of one of each starter block.
- PHP and Node version requirements are now enforced by Composer and npm themselves instead of custom checks in `doctor.ps1`: removed `"platform-check": false` from `composer.json` (Composer now enforces `"php": ">=8.3"` natively), and added `web/app/themes/starter-theme/.npmrc` with `engine-strict=true` (npm now enforces the theme's `package.json` `engines.node`). `doctor.ps1` still reports the detected versions but no longer duplicates the range checks.
- Moved the coding-convention rules (architecture, blocks, security) out of `docs/planning/AGENTS.md` into a root `AGENTS.md`, so they survive `scripts/new-instance.ps1` and reach every generated project instead of being deleted with the rest of the starter's internal planning docs.
- Folded `docs/BASELINE.md` into `AGENTS.md` and removed the duplicated block rules from `docs/BLOCKS.md` and the duplicated hooks list from `docs/PROJECT-CONFIG.md`.
- Folded `docs/SETUP.md` into `docs/CLONING.md` (they described the same onboarding flow from different angles) and removed it.
- Removed `docs/ARCHITECTURE.md`: its "Boundaries" rules moved into `AGENTS.md`, its "Design System" section was a duplicate of `docs/PROJECT-CONFIG.md`, and its "Blocks" section duplicated `docs/BLOCKS.md`. The runtime diagram it linked is now linked directly from `README.md`.
- Removed `docs/CLONING.md`: after the SETUP.md merge it mostly restated the README's own Setup section with more words. Folded its remaining unique content (`STARTER_*` PATH overrides, required `.env` keys, both LocalWP routing-mode examples, the `wp.ps1`/`seed-demo-content.ps1` reference commands) directly into `README.md`, which is now the single, complete setup doc — no separate file for "the full workflow".
- Removed `docs/PROJECT-CONFIG.md`: its `.env` and Validation sections duplicated README, and its Content Plugin section duplicated `AGENTS.md` (including an exact repeat of `site_content_setting()` that landed in both files during the `ARCHITECTURE.md` cleanup). Folded its genuinely unique content — design token paths, the feature-flags path, menu locations, and the baseline hooks list — into `AGENTS.md`, now the single source for all of it.
- Removed `docs/BLOCKS.md`: its "copy folder, rename" steps were generic dev practice, and its "normalization in `render.php`, markup in `component.blade.php`" instruction restated `AGENTS.md`'s existing "no business logic in Blade" rule. Folded its remaining unique content — the block folder/file structure, registering editor UI in `resources/js/blocks.js`, and running `validate.ps1` after a change — into `AGENTS.md`'s Blocks section.
- Moved `docs/planning/specs` to `docs/specs`, so `docs/planning` now holds only the implementation-plan doc; `docs/planning/README.md` was removed as no longer needed with a single file left. `scripts/new-instance.ps1` now removes both `docs/planning` and `docs/specs` from a generated project.

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
