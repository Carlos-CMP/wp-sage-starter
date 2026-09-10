# Block Foundation

## Intent

Implement the v1.0.0 Gutenberg block foundation so a fresh starter site exposes the starter components immediately after setup.

## Scope

- Register native Gutenberg blocks from self-contained folders under the Sage theme.
- Implement the four v1.0.0 blocks: Hero, Text + Image, CTA, Accordion / FAQ.
- Render blocks through PHP render callbacks delegating to Blade components.
- Use Gutenberg attributes and `InnerBlocks`; do not use ACF Blocks or ACF Pro-only features.
- Provide default demo content so a new local site can show the components without manual block construction.
- Document the block folder convention briefly.

## Out Of Scope

- Backlog v1.1+ blocks.
- ACF field groups for these blocks unless a simple field need appears later.
- Complex editor UI beyond native block controls.
- Full E2E tests.
- Project-specific branding or content models.

## Decision

The v1.0.0 blocks will be native dynamic blocks registered from PHP using `block.json`, Gutenberg attributes, `InnerBlocks` where needed, and Blade for presentation. The starter will include default block content that can be seeded after WordPress is created.
