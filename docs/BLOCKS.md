# Blocks

Blocks live in:

```text
web/app/themes/starter-theme/resources/views/blocks/<slug>/
```

Each block owns:

- `block.json`
- `render.php`
- `component.blade.php`
- `README.md`

## Add A Block

1. Copy an existing block folder.
2. Change the block `name`, `title`, attributes, and README.
3. Keep input normalization in `render.php`.
4. Keep markup in `component.blade.php`.
5. Register editor UI in `resources/js/blocks.js`.
6. Run:

```powershell
.\scripts\validate.ps1
```

## Rules

- Use native Gutenberg attributes.
- Use `InnerBlocks` for repeated or nested content.
- Do not use ACF Blocks, repeaters, flexible content, clone fields, or Options Pages.
- Do not put business logic in Blade.
- Consume design tokens instead of hardcoding brand values.
