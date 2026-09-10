# Proposal: site-content plugin foundation

## Intent

Create the `site-content` plugin as the content/domain boundary for the starter. This keeps project content models, global settings, feature flags, hooks, and filters out of the Sage theme.

This corresponds to Phase 2 of the implementation plan.

## Scope

### In scope

- Plugin bootstrap at `web/app/plugins/site-content/site-content.php`.
- Minimal modular folder structure.
- Versioned feature configuration.
- Example CPT disabled by default.
- Example taxonomy disabled by default.
- Native WordPress Settings API admin page.
- Global site settings for logo, phone, email, address, social links, and global notice.
- Sanitized settings persistence.
- Small documented helper for theme consumption.
- One hook/filter extension pattern.
- Short plugin README.

### Out of scope

- Project-specific CPTs, taxonomies, or business logic.
- ACF Pro or paid-only ACF features.
- ACF block registration.
- Gutenberg block implementation.
- Theme markup/styling dependencies.
- PHPUnit setup.

## Acceptance

- Plugin can activate without depending on Sage internals.
- Example CPT and taxonomy do not register by default.
- Example CPT and taxonomy can be enabled through versioned flags.
- Settings page registers and sanitizes all configured values.
- Theme code can read global settings through a documented interface.
- No project-specific content model is introduced.

## Decisions Made

- Use a lightweight plugin-local autoloader instead of adding a plugin Composer project.
- Store feature flags in `web/app/plugins/site-content/config/features.php`.
- Store global settings in one WordPress option array named `site_content_settings`.
