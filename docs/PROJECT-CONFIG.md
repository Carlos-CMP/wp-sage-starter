# Project Config

## Environment

Secrets and environment-specific values belong in `.env`.

Required local values:

- `DB_NAME`
- `DB_USER`
- `DB_PASSWORD`
- `DB_HOST`
- `WP_HOME`
- salts

Do not commit `.env`.

## Design Tokens

Default tokens:

```text
web/app/themes/starter-theme/resources/design-system/tokens.css
```

Project overrides:

```text
web/app/themes/starter-theme/resources/design-system/project-tokens.css
```

Change tokens before changing component markup.

## Content Plugin

Content/domain configuration belongs in:

```text
web/app/plugins/site-content/
```

Feature flags live in:

```text
web/app/plugins/site-content/config/features.php
```

Global settings are available through:

```php
site_content_setting('key', $default);
```

## Menus

Theme locations:

- `primary_navigation`
- `footer_navigation`

## Hooks

Use baseline hooks instead of editing shared templates for snippets:

- `starter_head`
- `starter_body_open`
- `starter_before_footer`

## Validation

```powershell
.\scripts\validate.ps1
```
