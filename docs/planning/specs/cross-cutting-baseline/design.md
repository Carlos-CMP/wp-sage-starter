# Cross-Cutting Baseline Design

## Approach

Add `docs/BASELINE.md` as the operational reference for generated projects.

Implement generic hooks in the main layout:

- `starter_head`
- `starter_body_open`
- `starter_before_footer`

These hooks let projects add analytics, consent, or marketing snippets without editing core templates.

Add basic security headers through WordPress `send_headers`:

- `X-Content-Type-Options: nosniff`
- `Referrer-Policy: strict-origin-when-cross-origin`
- `X-Frame-Options: SAMEORIGIN`

Keep debug exposure controlled by Bedrock config and environment files.

Wrap block editor UI strings in `@wordpress/i18n`.

## Affected Files

- `docs/BASELINE.md`
- `docs/ARCHITECTURE.md`
- `README.md`
- `web/app/themes/starter-theme/app/setup.php`
- `web/app/themes/starter-theme/resources/views/layouts/app.blade.php`
- `web/app/themes/starter-theme/resources/js/blocks.js`

## Validation

- PHP syntax check.
- Composer lint.
- Theme build.
- WP-CLI hook/theme smoke.
- HTTP smoke for homepage.
