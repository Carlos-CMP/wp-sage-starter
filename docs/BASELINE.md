# Baseline

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

Use these hooks from a project plugin or child project customization:

```php
add_action('starter_head', function () {
    // Head snippet.
});

add_action('starter_body_open', function () {
    // Body-open snippet.
});

add_action('starter_before_footer', function () {
    // Footer snippet.
});
```

Consent and provider choice belong to each generated project.

## Forms

The starter does not require a forms plugin. Form blocks or embeds must sanitize input, use nonces, validate capability where needed, and avoid storing submissions unless the project explicitly requires it.

## Logging And Errors

- Production must not display PHP or WordPress debug errors.
- Use environment configuration for debug logging.
- Do not commit logs or secrets.

## Security

- File editing is disabled from wp-admin.
- Plugin/theme modification from wp-admin is disabled by default.
- The theme sends basic security headers through WordPress.
- Privileged or state-changing features must use nonces and capability checks.
