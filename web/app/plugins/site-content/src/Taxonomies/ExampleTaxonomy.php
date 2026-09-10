<?php

declare(strict_types=1);

namespace SiteContent\Taxonomies;

final class ExampleTaxonomy
{
    public static function register(): void
    {
        add_action('init', [self::class, 'registerTaxonomy']);
    }

    public static function registerTaxonomy(): void
    {
        register_taxonomy('example_topic', ['example_project'], [
            'labels' => [
                'name' => __('Example Topics', 'site-content'),
                'singular_name' => __('Example Topic', 'site-content'),
            ],
            'public' => false,
            'show_ui' => true,
            'show_in_rest' => true,
            'hierarchical' => true,
        ]);
    }
}
