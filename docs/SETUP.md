# Setup

This starter targets Windows + LocalWP only — the bootstrap scripts are PowerShell and rely on Windows-only NTFS junctions, and no other local runtime is documented or supported. The starter does not control LocalWP directly.

Create your project repository from this starter using GitHub's **Use this template** button (not `git clone` — see `docs/CLONING.md`), then clone your new repository. Right after cloning, run `.\scripts\new-instance.ps1` once to drop the starter's internal planning docs before doing anything else.

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

This creates or updates the `Starter Components` homepage with a single Hero block as a smoke test.

## Validation

```powershell
.\scripts\validate.ps1
```
