# Quality CI Design

## Approach

Frontend tooling lives in the Sage theme because the JavaScript and CSS source lives there.

Root validation is orchestrated by `scripts/validate.ps1`:

- Composer validate.
- Composer lint.
- Theme npm lint.
- Theme npm format check.
- Theme npm build.

GitHub Actions mirrors those checks on Ubuntu with PHP 8.3 and Node 22.

## Affected Files

- `.github/workflows/validate.yml`
- `scripts/validate.ps1`
- `web/app/themes/starter-theme/package.json`
- `web/app/themes/starter-theme/eslint.config.js`
- `web/app/themes/starter-theme/.prettierrc.json`
- `docs/SETUP.md`
- `README.md`

## Validation

- Run `npm run lint`.
- Run `npm run format`.
- Run `npm run build`.
- Run `scripts/validate.ps1`.
