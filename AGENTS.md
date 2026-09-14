# Agent Rules

## Architecture

- Bedrock owns WordPress bootstrap, dependencies, and environment configuration; Sage owns presentation, Blade templates, Tailwind, and Gutenberg rendering; `site-content` owns CPTs, taxonomies, settings, feature flags, hooks, and filters.
- Theme code is presentation only and must not contain project content models.
- Content/domain configuration belongs in `site-content`, which must not depend on theme markup.
- Theme code reads global settings through `site_content_setting($key, $default)`.
- Feature flags live in `web/app/plugins/site-content/config/features.php`.
- Secrets and environment values belong in `.env`.
- Non-sensitive behavior belongs in versioned project config.
- Default design tokens live in `web/app/themes/starter-theme/resources/design-system/tokens.css`; project branding overrides go in `.../design-system/project-tokens.css`. Change tokens before changing component markup.
- Theme menu locations: `primary_navigation`, `footer_navigation`.

## Blocks

- Blocks must be modular and independently removable.
- Do not use ACF Pro APIs, ACF Blocks, repeaters, flexible content, clone fields, or Options Pages.
- Use Gutenberg attributes and `InnerBlocks` for repeated or nested content.
- Do not put business logic in Blade.
- Components consume design tokens.

## Accessibility

- Use semantic landmarks: header, nav, main, footer.
- Keep one visible page heading per main view.
- Preserve the skip link.
- Use real buttons for actions and links for navigation.
- Every image needs useful alt text or empty alt when decorative.

## Performance

- Keep blocks self-contained and avoid global JavaScript when PHP/HTML is enough.
- Use WordPress responsive image helpers for media from the library.
- Do not add cache plugins by default.
- Treat third-party scripts as project decisions.

## SEO Compatibility

- The theme supports `title-tag` and leaves metadata ownership to WordPress or a project-selected SEO plugin.
- Templates must render clean headings and readable content without depending on a specific SEO plugin.
- Do not hardcode provider-specific metadata in starter templates.

## Analytics And Marketing

Add analytics or marketing snippets through these hooks, from a project plugin or child project customization, instead of editing shared templates:

- `starter_head`
- `starter_body_open`
- `starter_before_footer`

Consent and provider choice belong to each generated project.

## Forms

The starter does not require a forms plugin. Form blocks or embeds must sanitize input, use nonces, validate capability where needed, and avoid storing submissions unless the project explicitly requires it.

## Logging And Errors

- Production must not display PHP or WordPress debug errors.
- Use environment configuration for debug logging.
- Do not commit logs or secrets.

## Security

- Never commit secrets.
- Sanitize input and escape output.
- Use WordPress nonces and capabilities for privileged or state-changing behavior.
- File editing and plugin/theme modification from wp-admin are disabled by default.
- The theme sends basic security headers through WordPress.

## Harness

- Run `.\scripts\doctor.ps1` before implementation work in this repo.
- If doctor reports `ERROR`, fix it or ask before changing code.
- If doctor reports only `WARN`, proceed only if the warning does not affect the task.
