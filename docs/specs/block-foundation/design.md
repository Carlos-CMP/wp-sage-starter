# Block Foundation Design

## Approach

Blocks live in `resources/views/blocks/<slug>/` and each folder owns:

- `block.json`
- `render.php`
- `component.blade.php`
- optional `README.md`

The theme registers all block folders on `init` using `register_block_type()`. Each `render.php` receives attributes, content, and block context, normalizes data, then renders the matching Blade component through Sage's view layer.

## Blocks

- `starter/hero`: text, CTAs, image URL/alt, alignment, variant.
- `starter/text-image`: text, CTA, image URL/alt, image position, variant.
- `starter/cta`: text, primary/secondary CTA, variant.
- `starter/accordion`: title plus `InnerBlocks` restricted to `starter/accordion-item`.
- `starter/accordion-item`: question attribute plus answer from `InnerBlocks`.

The accordion parent and item are both native blocks so repeated FAQ content does not require ACF Pro repeaters.

## Editor Assets

Use a small editor script to register block edit UIs with native WordPress packages. Blocks are dynamic on the frontend, but editor previews use matching structural markup where practical.

The existing `resources/js/editor.js` entry imports `resources/js/blocks.js`, so WordPress loads a single editor entrypoint and one generated dependency file.

## Demo Content

Add a WP-CLI script that creates or updates a "Starter Components" page containing the four v1.0.0 blocks. This makes a created LocalWP site load the components without manual authoring.

## Affected Files

- `web/app/themes/starter-theme/app/setup.php`
- `web/app/themes/starter-theme/resources/js/blocks.js`
- `web/app/themes/starter-theme/resources/views/blocks/**`
- `web/app/themes/starter-theme/vite.config.js`
- `scripts/seed-demo-content.ps1`
- `docs/ARCHITECTURE.md`
- `docs/SETUP.md`

## Validation

- PHP syntax check for new PHP files.
- `npm run build` in the theme.
- `composer lint`.
- WP-CLI block registration smoke check.
- Seed demo page through WP-CLI and verify it exists.
