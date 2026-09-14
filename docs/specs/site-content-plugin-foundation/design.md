# Design: site-content plugin foundation

## Approach

Build a small first-party WordPress plugin with explicit classes and no theme dependency. The plugin owns settings and optional example content model registration; the theme can consume settings through a function, not by reading plugin internals.

## Structure

```text
web/app/plugins/site-content/
|- config/
|  `- features.php
|- src/
|  |- Filters/
|  |  `- ExampleFilter.php
|  |- Hooks/
|  |  `- ExampleHook.php
|  |- PostTypes/
|  |  `- ExamplePostType.php
|  |- Settings/
|  |  `- SiteSettings.php
|  |- Support/
|  |  |- Config.php
|  |  `- Settings.php
|  |- Taxonomies/
|  |  `- ExampleTaxonomy.php
|  `- Plugin.php
|- README.md
`- site-content.php
```

## Bootstrap

`site-content.php` defines plugin metadata, registers a small PSR-4 style autoloader for the `SiteContent\` namespace, defines the public helper function `site_content_setting()`, and boots `SiteContent\Plugin` on `plugins_loaded`.

## Feature Flags

`config/features.php` returns:

```php
return [
    'example_post_type' => false,
    'example_taxonomy' => false,
];
```

Disabled features do not register runtime WordPress content models.

## Settings

`SiteSettings` uses the Settings API:

- option group: `site_content`
- option name: `site_content_settings`
- settings page: Settings > Site Content

Fields:

- logo
- phone
- email
- address
- social_links
- global_notice

Sanitization:

- `logo`: `esc_url_raw`
- `phone`: `sanitize_text_field`
- `email`: `sanitize_email`
- `address`: `sanitize_textarea_field`
- `social_links`: `sanitize_textarea_field`
- `global_notice`: `sanitize_textarea_field`

## Theme Interface

Expose:

```php
site_content_setting(string $key, mixed $default = null): mixed
```

This keeps Sage from depending on plugin classes.

## Validation

- Run `C:\php83\php.exe -l` on plugin PHP files.
- Run Composer lint from the project root.
- Use WP-CLI only for plugin availability checks if `.env` exists; otherwise record local activation as blocked by missing runtime config.

## Tradeoffs

### Plugin-local autoloader

Chosen to avoid adding plugin Composer infrastructure before the plugin has real package needs.

### One option array

Chosen because the settings set is small and easier to consume as a single contract.
