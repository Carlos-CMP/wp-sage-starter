# Starter Doctor

## Intent

Improve the first-use experience for developers and agents by adding a read-only preflight check for required local tools before bootstrap or implementation work starts.

## Problem

Today a user can clone the starter and only discover missing or mismatched tooling during `new-project.ps1`, `validate.ps1`, Composer, npm, or WP-CLI execution. That creates noisy failures and makes it harder for an agent to know whether the environment is ready.

## Scope

- Add a `scripts/doctor.ps1` command that checks local prerequisites without modifying the machine or project.
- Report each check as `OK`, `WARN`, or `ERROR`.
- Check PHP, Composer, Node/npm, WP-CLI, Git, LocalWP presence, `.env`, WordPress DB connectivity when available, and theme build prerequisites.
- Add agent guidance so future sessions run the doctor first when starting work in this repo.
- Document the command in setup docs.

## Out Of Scope

- Installing missing tools.
- Auto-running scripts on clone.
- Changing Git hooks to execute code automatically.
- Controlling LocalWP services.
- Replacing `new-project.ps1` or `validate.ps1`.

## Success Criteria

- A user can run one command after cloning and know what is missing.
- An agent can run the same command before changing files.
- The command is safe to run repeatedly.
- The command fails with non-zero exit code only for blocking issues.
