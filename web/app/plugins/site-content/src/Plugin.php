<?php

declare(strict_types=1);

namespace SiteContent;

use SiteContent\Filters\ExampleFilter;
use SiteContent\Hooks\ExampleHook;
use SiteContent\PostTypes\ExamplePostType;
use SiteContent\Settings\SiteSettings;
use SiteContent\Support\Config;
use SiteContent\Taxonomies\ExampleTaxonomy;

final class Plugin
{
    public static function boot(): void
    {
        SiteSettings::register();
        ExampleHook::register();
        ExampleFilter::register();

        if (Config::feature('example_post_type')) {
            ExamplePostType::register();
        }

        if (Config::feature('example_taxonomy')) {
            ExampleTaxonomy::register();
        }

        do_action('site_content_loaded');
    }
}
