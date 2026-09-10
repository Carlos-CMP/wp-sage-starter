# Agent Rules

## Architecture

- Theme code is presentation only.
- Content/domain configuration belongs in `site-content`.
- Secrets and environment values belong in `.env`.
- Non-sensitive behavior belongs in versioned project config.

## Blocks

- Blocks must be modular and independently removable.
- Do not use ACF Pro APIs, ACF Blocks, repeaters, flexible content, clone fields, or Options Pages.
- Use Gutenberg attributes and `InnerBlocks` for repeated or nested content.
- Do not put business logic in Blade.
- Components consume design tokens.

## Security

- Never commit secrets.
- Sanitize input and escape output.
- Use WordPress nonces and capabilities for privileged or state-changing behavior.

## Harness

- Follow `specs/CONSTITUTION.md`.
- Work from proposal, design, and tasks.
- Keep changes small and independently verifiable.
- Update docs only when conventions or commands change.
