# Bootstrap Automation

## Intent

Provide one repeatable local bootstrap command for projects created from the starter.

## Scope

- Add `new-project.ps1`.
- Validate PHP 8.3, Composer, Node/npm, and WP-CLI.
- Create `.env` from parameters when it does not exist.
- Install Composer and theme npm dependencies.
- Build theme assets.
- Activate the starter theme and `site-content` plugin.
- Run demo seed content.
- Print a concise completion summary.

## Out Of Scope

- Controlling LocalWP services.
- Docker.
- Remote deployment.
- Rewriting project/package names across the repository.

## Decision

The bootstrap script will be local-first and conservative: it will not overwrite `.env` unless `-ForceEnv` is passed, and it assumes LocalWP already exists and is running.
