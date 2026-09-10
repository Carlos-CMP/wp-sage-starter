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

Check local prerequisites first:

```powershell
.\scripts\doctor.ps1
```

If the repo is not already serving LocalWP's `app/public`, link it:

```powershell
.\scripts\link-localwp.ps1 -LocalSitePath "$env:USERPROFILE\Local Sites\starter-sage-wp"
```

Then bootstrap with the DB host and frontend URL shown by LocalWP:

```powershell
.\new-project.ps1 -ProjectName "My Project" -Domain "my-project.local" -DbHost 127.0.0.1:10023
```

Use `-Domain "localhost:<port>"` when LocalWP is in localhost Routing Mode.

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
