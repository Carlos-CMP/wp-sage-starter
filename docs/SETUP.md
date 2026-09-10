# Setup

LocalWP is the recommended local runtime. The starter does not control LocalWP directly.

## Environment

Copy `.env.example` to `.env` and fill:

- `DB_NAME`
- `DB_USER`
- `DB_PASSWORD`
- `DB_HOST`
- `WP_HOME`
- salts

Keep `.env` out of version control.

## Install

```powershell
.\new-project.ps1 -DbHost 127.0.0.1:10023
```

Use the MySQL host/port shown by LocalWP for the project.

## WP-CLI

```powershell
.\scripts\wp.ps1 --info
```

Commands that load WordPress require `.env` with LocalWP database and URL values.

## Demo Content

```powershell
.\scripts\seed-demo-content.ps1
```

This creates or updates the `Starter Components` homepage with the v1.0.0 blocks.

## Validation

```powershell
.\scripts\validate.ps1
```
