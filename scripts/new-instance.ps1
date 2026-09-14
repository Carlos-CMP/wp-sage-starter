<#
Run this once, right after creating a project from this starter, to remove
the starter's own internal planning docs (not relevant to a client project).

Git history and the starter remote don't need resetting here: create new
projects with GitHub's "Use this template" button on the starter repo, which
already starts the new repository with a single commit and no `origin`
pointing back to the starter.
#>
param(
    [switch] $Force
)

$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $PSScriptRoot
$targets = @(
    (Join-Path $root 'docs\planning'),
    (Join-Path $root 'docs\specs')
) | Where-Object { Test-Path -LiteralPath $_ }

if (-not $targets) {
    'docs/planning and docs/specs not found; nothing to remove.'
    exit 0
}

if (-not $Force) {
    $list = ($targets | ForEach-Object { Resolve-Path -LiteralPath $_ -Relative }) -join ', '
    $confirmation = Read-Host "Remove $list (the starter's own internal build docs)? [y/N]"
    if ($confirmation -notmatch '^[Yy]') {
        'Aborted.'
        exit 1
    }
}

foreach ($target in $targets) {
    Remove-Item -LiteralPath $target -Recurse -Force
    "Removed $target"
}
