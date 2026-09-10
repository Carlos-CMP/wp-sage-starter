param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]] $WpArgs
)

$ErrorActionPreference = 'Stop'

$php = 'C:\php83\php.exe'
$wpCli = 'C:\wp-cli\wp-cli.phar'

if (-not (Test-Path -LiteralPath $php)) {
    throw "PHP 8.3 not found at $php"
}

if (-not (Test-Path -LiteralPath $wpCli)) {
    throw "WP-CLI not found at $wpCli"
}

& $php $wpCli @WpArgs
exit $LASTEXITCODE
