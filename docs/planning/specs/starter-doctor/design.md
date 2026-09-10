# Starter Doctor Design

## Command

```powershell
.\scripts\doctor.ps1
```

Optional flags:

- `-Json`: emit machine-readable JSON for agents.
- `-Strict`: return non-zero for warnings as well as errors.

## Checks

Required checks:

- PHP executable exists at `C:\php83\php.exe`.
- PHP version is `>=8.3`.
- Composer PHAR exists at `C:\ProgramData\ComposerSetup\bin\composer.phar`.
- Composer can run with PHP 8.3.
- Git is available.
- Node and npm are available.
- Node version satisfies the theme `engines.node` range.
- WP-CLI PHAR exists at `C:\wp-cli\wp-cli.phar`.
- `scripts/wp.ps1` can run `--info`.

Contextual checks:

- `.env` exists.
- If `.env` exists, required keys are present.
- If `.env` exists and DB is reachable, `wp core version`, `wp plugin list`, and `wp theme list` run.
- LocalWP executable or config is detected.
- If LocalWP site metadata is detectable, show likely DB host/port candidates.

## Output

Human output should be concise:

```text
OK    PHP 8.3.33 at C:\php83\php.exe
WARN  LocalWP detected, but starter site is not running
ERROR WP-CLI missing at C:\wp-cli\wp-cli.phar
```

JSON output should include:

- `status`
- `name`
- `message`
- `details`

## Agent Integration

Update `AGENTS.md` with a startup rule:

- When beginning work in this repo, run `.\scripts\doctor.ps1`.
- If it reports `ERROR`, fix or ask before implementation.
- If it reports only `WARN`, proceed only if the warning does not affect the requested task.

This keeps verification explicit without executing code automatically on clone.

## Open Decisions

1. Should `doctor.ps1` assume the fixed paths from this machine (`C:\php83`, `C:\wp-cli`) or discover tools from `PATH` first and only warn about non-standard paths?

Decision: require the preferred project paths. A user who wants to use the starter must adapt their environment to those paths.

2. Should missing LocalWP be `WARN` or `ERROR`?

Recommended: `WARN`, because the constitution says LocalWP is recommended, not mandatory.

3. Should missing `.env` be `WARN` or `ERROR`?

Recommended: `WARN` for `doctor.ps1`, `ERROR` for bootstrap/commands that need WordPress DB access.

## Resolved Decisions

- Required PHP path: `C:\php83\php.exe`.
- Required Composer path: `C:\ProgramData\ComposerSetup\bin\composer.phar`.
- Required WP-CLI path: `C:\wp-cli\wp-cli.phar`.
- Required Git path: `C:\Program Files\Git\cmd\git.exe`.
- Required Node path: `C:\Program Files\nodejs\node.exe`.
- Required npm path: `C:\Program Files\nodejs\npm.cmd`.
- LocalWP missing or stopped: `WARN`.
- `.env` missing: `WARN`.
