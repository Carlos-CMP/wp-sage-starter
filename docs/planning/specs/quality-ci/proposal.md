# Quality CI

## Intent

Add the minimum validation layer for v1.0.0 so generated projects can catch broken PHP style, frontend syntax, and failed theme builds early.

## Scope

- Add ESLint and Prettier configuration for theme frontend files.
- Add npm scripts for lint and formatting checks.
- Add a local smoke validation script.
- Add a GitHub Actions workflow that installs PHP/Node dependencies and runs validation.

## Out Of Scope

- Deployment.
- Artifact packaging.
- PHPUnit/E2E as mandatory gates.
- Security scanners.

## Decision

CI remains validation-only: Composer validate, PHP lint/style, frontend lint/format, and Sage production build.
