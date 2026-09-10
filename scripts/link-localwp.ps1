param(
    [Parameter(Mandatory = $true)]
    [string] $LocalSitePath
)

$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $PSScriptRoot
$target = Join-Path $root 'web'
$sitePath = [System.IO.Path]::GetFullPath((Resolve-Path -LiteralPath $LocalSitePath).Path)
$appPath = Join-Path $sitePath 'app'
$publicPath = Join-Path $appPath 'public'

if (-not (Test-Path -LiteralPath $target)) {
    throw "Starter web directory not found at $target"
}

if (-not (Test-Path -LiteralPath $appPath)) {
    throw "LocalWP app directory not found at $appPath"
}

$resolvedApp = [System.IO.Path]::GetFullPath((Resolve-Path -LiteralPath $appPath).Path)
$resolvedPublic = [System.IO.Path]::GetFullPath($publicPath)

if (-not $resolvedPublic.StartsWith($resolvedApp, [System.StringComparison]::OrdinalIgnoreCase)) {
    throw "Refusing to move a directory outside $resolvedApp"
}

if (Test-Path -LiteralPath $publicPath) {
    $item = Get-Item -LiteralPath $publicPath -Force
    if (($item.Attributes -band [System.IO.FileAttributes]::ReparsePoint) -and ($item.Target -eq $target)) {
        "LocalWP public directory already points to $target"
        exit 0
    }

    $backup = Join-Path $appPath ("public.localwp-backup-{0}" -f (Get-Date -Format 'yyyyMMdd-HHmmss'))
    Move-Item -LiteralPath $publicPath -Destination $backup
    "Existing LocalWP public directory moved to $backup"
}

New-Item -ItemType Junction -Path $publicPath -Target $target | Out-Null
"LocalWP public directory now points to $target"
