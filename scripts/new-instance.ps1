<#
Run this once, right after cloning this starter, to turn the clone into an
independent project:

- Removes docs/planning (the starter's own internal build/planning docs;
  not relevant to a client project).
- Resets git history to a single clean commit, with no starter git history
  and no `origin` remote, so the new project owns its history from commit 1.

Run scripts\doctor.ps1 and new-project.ps1 after this, not before, since
this rewrites the working tree and git history.
#>
param(
    [switch] $KeepPlanningDocs,
    [switch] $Force
)

$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $PSScriptRoot

. (Join-Path $PSScriptRoot '_tools.ps1')

$git = Get-GitPath
Assert-Tool -Name 'Git' -Path $git -EnvVar 'STARTER_GIT'

function Invoke-Git {
    param([Parameter(ValueFromRemainingArguments = $true)] [string[]] $Arguments)

    & $git @Arguments
    if ($LASTEXITCODE -ne 0) {
        throw "git $($Arguments -join ' ') failed with exit code $LASTEXITCODE"
    }
}

Push-Location $root
try {
    & $git rev-parse --is-inside-work-tree *>$null
    if ($LASTEXITCODE -ne 0) {
        throw "$root is not a git repository."
    }

    $status = & $git status --porcelain
    if ($status -and -not $Force) {
        throw "Working tree has uncommitted changes. Commit or stash them first, or pass -Force to proceed anyway."
    }

    if (-not $Force) {
        $confirmation = Read-Host 'This rewrites local git history and removes docs/planning (unless -KeepPlanningDocs). Continue? [y/N]'
        if ($confirmation -notmatch '^[Yy]') {
            'Aborted.'
            exit 1
        }
    }

    $planningDocs = Join-Path $root 'docs\planning'
    if ((-not $KeepPlanningDocs) -and (Test-Path -LiteralPath $planningDocs)) {
        Remove-Item -LiteralPath $planningDocs -Recurse -Force
        "Removed $planningDocs"
    }

    $originalBranch = (& $git rev-parse --abbrev-ref HEAD).Trim()
    $tempBranch = '__new_project__'

    Invoke-Git checkout --orphan $tempBranch
    Invoke-Git add -A
    Invoke-Git commit -m 'Initial commit from WordPress Sage Starter'
    Invoke-Git branch -D $originalBranch
    Invoke-Git branch -m $originalBranch

    $hasOrigin = (& $git remote) -contains 'origin'
    if ($hasOrigin) {
        Invoke-Git remote remove origin
        'Removed the starter git remote (origin).'
    }

    "This project now has a single commit on '$originalBranch' with no starter history or remote."
    'Add your own remote when ready: git remote add origin <url>'
} finally {
    Pop-Location
}
