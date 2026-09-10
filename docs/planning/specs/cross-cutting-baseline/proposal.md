# Cross-Cutting Baseline

## Intent

Add the minimum starter-wide conventions needed before v1.0.0 can be reused safely across projects.

## Scope

- Accessibility checklist.
- Performance conventions.
- SEO compatibility conventions.
- Analytics/marketing integration hooks.
- Form integration convention.
- Native logging/error rules.
- Cache convention documentation.
- Native security baseline.
- Translatable editor strings.

## Out Of Scope

- Installing SEO, analytics, security, cache, cookie, multilingual, or forms plugins.
- Provider-specific integrations.
- Automated accessibility or E2E tooling.
- Custom consent-management implementation.

## Decision

The baseline will be documented and implemented only where a tiny generic hook or WordPress-native setting prevents future template edits. No third-party plugin becomes required.
