<?php

declare(strict_types=1);

namespace SiteContent\Hooks;

final class ExampleHook
{
    public static function register(): void
    {
        add_action('site_content_loaded', '__return_true');
    }
}
