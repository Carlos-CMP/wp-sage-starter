param()

$ErrorActionPreference = 'Stop'

$wp = Join-Path $PSScriptRoot 'wp.ps1'
$tempFile = Join-Path ([System.IO.Path]::GetTempPath()) 'starter-components-content.html'

$content = @'
<!-- wp:starter/hero {"eyebrow":"Starter","title":"WordPress Sage Starter","text":"A reusable foundation for marketing websites with Bedrock, Sage, Gutenberg blocks, and replaceable design tokens.","primaryCtaLabel":"View components","primaryCtaUrl":"#components","secondaryCtaLabel":"Read setup","secondaryCtaUrl":"/wp-admin/","alignment":"left","variant":"default"} /-->

<!-- wp:starter/text-image {"title":"Design-system first","text":"Components consume shared tokens so project branding can change without rewriting block markup.","ctaLabel":"Architecture","ctaUrl":"/","imagePosition":"right","variant":"muted"} /-->

<!-- wp:starter/cta {"title":"Ready for project work","text":"Use this page as a smoke test when a new starter instance is created.","primaryCtaLabel":"Open editor","primaryCtaUrl":"/wp-admin/post.php","secondaryCtaLabel":"Visit dashboard","secondaryCtaUrl":"/wp-admin/","variant":"default"} /-->

<!-- wp:starter/accordion {"title":"Starter FAQ","variant":"default"} -->
<!-- wp:starter/accordion-item {"question":"Does this require ACF Pro?"} -->
<!-- wp:paragraph -->
<p>No. Repeated and nested content uses native Gutenberg blocks.</p>
<!-- /wp:paragraph -->
<!-- /wp:starter/accordion-item -->

<!-- wp:starter/accordion-item {"question":"Where does domain content belong?"} -->
<!-- wp:paragraph -->
<p>Project content configuration belongs in the site-content plugin, not in the theme.</p>
<!-- /wp:paragraph -->
<!-- /wp:starter/accordion-item -->
<!-- /wp:starter/accordion -->
'@

[System.IO.File]::WriteAllText($tempFile, $content, [System.Text.UTF8Encoding]::new($false))

$pageId = & $wp post list --post_type=page --name='starter-components' --field=ID

if ($pageId) {
    & $wp post update $pageId $tempFile --post_title='Starter Components' --post_name='starter-components' --post_status=publish | Out-Null
} else {
    $pageId = & $wp post create $tempFile --post_type=page --post_title='Starter Components' --post_name='starter-components' --post_status=publish --porcelain
}

& $wp option update show_on_front page | Out-Null
& $wp option update page_on_front $pageId | Out-Null

$frontId = & $wp option get page_on_front
$primaryMenuId = & $wp term list nav_menu --slug='starter-primary' --field=term_id

if (-not $primaryMenuId) {
    $primaryMenuId = & $wp menu create 'Starter Primary' --porcelain
}

$primaryItems = & $wp menu item list $primaryMenuId --format=count
if ($primaryItems -eq '0') {
    & $wp menu item add-post $primaryMenuId $frontId --title='Home' | Out-Null
    & $wp menu item add-post $primaryMenuId $pageId --title='Components' | Out-Null
}

$footerMenuId = & $wp term list nav_menu --slug='starter-footer' --field=term_id

if (-not $footerMenuId) {
    $footerMenuId = & $wp menu create 'Starter Footer' --porcelain
}

$footerItems = & $wp menu item list $footerMenuId --format=count
if ($footerItems -eq '0') {
    & $wp menu item add-post $footerMenuId $pageId --title='Components' | Out-Null
    & $wp menu item add-custom $footerMenuId 'Dashboard' '/wp-admin/' | Out-Null
}

& $wp menu location assign $primaryMenuId primary_navigation | Out-Null
& $wp menu location assign $footerMenuId footer_navigation | Out-Null

"Seeded Starter Components page: $pageId"
