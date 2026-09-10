# Architecture

## Boundaries

- Bedrock owns WordPress bootstrap, dependencies, and environment configuration.
- Sage owns presentation, Blade templates, Tailwind, and Gutenberg rendering.
- `site-content` owns CPTs, taxonomies, settings, feature flags, hooks, and filters.

Theme code must not contain project content models. `site-content` must not depend on theme markup.

Theme code reads global settings through `site_content_setting($key, $default)`.

## Design System

Default tokens live in:

```text
web/app/themes/starter-theme/resources/design-system/tokens.css
```

Generated projects should override branding in:

```text
web/app/themes/starter-theme/resources/design-system/project-tokens.css
```

Change tokens before changing component markup.

## Blocks

Starter blocks live in:

```text
web/app/themes/starter-theme/resources/views/blocks/<slug>/
```

Each block owns `block.json`, `render.php`, `component.blade.php`, and a short README. Blocks are native Gutenberg blocks rendered through Blade; repeated FAQ content uses `InnerBlocks`.

## Baseline Hooks

Projects can add analytics or marketing snippets without editing templates through:

```text
starter_head
starter_body_open
starter_before_footer
```
