<?php

declare(strict_types=1);

namespace SiteContent\PostTypes;

final class ExamplePostType
{
    public static function register(): void
    {
        add_action('init', [self::class, 'registerPostType']);
    }

    public static function registerPostType(): void
    {
        register_post_type('example_project', [
            'labels' => [
                'name' => __('Example Projects', 'site-content'),
                'singular_name' => __('Example Project', 'site-content'),
            ],
            'public' => false,
            'show_ui' => true,
            'show_in_rest' => true,
            'supports' => ['title', 'editor', 'thumbnail'],
        ]);
    }
}
