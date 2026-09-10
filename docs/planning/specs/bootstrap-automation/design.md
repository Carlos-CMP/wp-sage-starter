# Bootstrap Automation Design

## Command

`new-project.ps1` lives at the repository root and accepts:

- `-ProjectName`
- `-Domain`
- `-DbHost`
- `-DbName`
- `-DbUser`
- `-DbPassword`
- `-ForceEnv`
- `-SkipInstall`

Defaults target the LocalWP convention:

- `ProjectName`: `WordPress Sage Starter`
- `Domain`: `starter-sage-wp.local`
- `DbName`: `local`
- `DbUser`: `root`
- `DbPassword`: `root`

`DbHost` is required unless `.env` already exists because LocalWP uses per-site MySQL ports.

## Flow

1. Validate required local tools.
2. Create `.env` if missing.
3. Run Composer install.
4. Run theme npm install/build.
5. Activate `site-content`.
6. Activate `starter-theme`.
7. Set base site options.
8. Run `scripts/seed-demo-content.ps1`.
9. Print URLs and next checks.

## Validation

- PowerShell script parses and runs with `-SkipInstall`.
- WP-CLI plugin/theme checks pass after bootstrap.
- HTTP smoke remains green.
