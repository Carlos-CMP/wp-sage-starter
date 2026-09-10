# Base Templates Design

## Approach

Keep Sage's template hierarchy, but make default markup suitable for a starter:

- constrained content width for posts and utility pages
- full page content output for Gutenberg pages
- simple card-like list items for archives/search
- plain empty states with search fallback where relevant
- accessible labels for pagination and search

## Affected Files

- `resources/views/index.blade.php`
- `resources/views/page.blade.php`
- `resources/views/single.blade.php`
- `resources/views/search.blade.php`
- `resources/views/404.blade.php`
- `resources/views/partials/content*.blade.php`
- `resources/views/partials/page-header.blade.php`

## Validation

- PHP syntax check for changed Blade files.
- Composer lint.
- Theme build.
- HTTP smoke checks for home, sample post, search, and 404.
