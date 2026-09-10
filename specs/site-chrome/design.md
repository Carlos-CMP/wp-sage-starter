# Site Chrome Design

## Approach

The Sage theme owns presentation. `site-content` remains the source for optional global settings.

Header:

- site logo URL from `site_content_setting('logo')` when available
- site name fallback
- `primary_navigation` menu location

Footer:

- site name
- optional phone, email, address, and global notice from `site-content`
- `footer_navigation` menu location
- current year

Menus are registered in `app/setup.php`. Blade templates escape output and avoid business logic.

## Seed

Extend `scripts/seed-demo-content.ps1` to create reusable starter menus:

- Primary: Home, Components
- Footer: Components, Dashboard

The script assigns menus to the theme locations and can be safely rerun.

## Validation

- PHP syntax check.
- Composer lint.
- Theme build.
- WP-CLI menu/location checks.
- HTTP smoke check for header/footer content.
