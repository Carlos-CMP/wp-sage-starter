# Site Chrome

## Intent

Provide reusable starter header, navigation, and footer chrome so new WordPress projects begin with a working website shell.

## Scope

- Register primary and footer navigation locations.
- Render a generic accessible header with site identity and primary navigation.
- Render a generic accessible footer with footer navigation and optional global settings from `site-content`.
- Keep theme code presentation-only and project-neutral.
- Seed basic primary and footer menus for local starter demos.

## Out Of Scope

- Megamenus.
- Mobile JavaScript navigation.
- Project-specific branding.
- Social icon parsing beyond plain optional settings output.
- Footer widgets as the primary footer architecture.

## Decision

The starter shell will use WordPress menus and site identity as defaults, with optional contact/global settings read from `site_content_setting()` when the `site-content` plugin is active.
