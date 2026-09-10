<?php

declare(strict_types=1);

namespace SiteContent\Settings;

use SiteContent\Support\Settings;

final class SiteSettings
{
    /**
     * @var array<string, string>
     */
    private const FIELDS = [
        'logo' => 'Logo URL',
        'phone' => 'Phone',
        'email' => 'Email',
        'address' => 'Address',
        'social_links' => 'Social links',
        'global_notice' => 'Global notice',
    ];

    public static function register(): void
    {
        add_action('admin_menu', [self::class, 'addPage']);
        add_action('admin_init', [self::class, 'registerSettings']);
    }

    public static function addPage(): void
    {
        add_options_page(
            __('Site Content', 'site-content'),
            __('Site Content', 'site-content'),
            'manage_options',
            'site-content',
            [self::class, 'renderPage']
        );
    }

    public static function registerSettings(): void
    {
        register_setting('site_content', Settings::OPTION_NAME, [
            'type' => 'array',
            'sanitize_callback' => [self::class, 'sanitize'],
            'default' => [],
        ]);

        add_settings_section(
            'site_content_main',
            __('Global settings', 'site-content'),
            '__return_false',
            'site-content'
        );

        foreach (self::FIELDS as $key => $label) {
            add_settings_field(
                $key,
                esc_html__($label, 'site-content'),
                [self::class, 'renderField'],
                'site-content',
                'site_content_main',
                ['key' => $key]
            );
        }
    }

    /**
     * @return array<string, string>
     */
    public static function sanitize(mixed $input): array
    {
        if (! is_array($input)) {
            return [];
        }

        return [
            'logo' => esc_url_raw((string) ($input['logo'] ?? '')),
            'phone' => sanitize_text_field((string) ($input['phone'] ?? '')),
            'email' => sanitize_email((string) ($input['email'] ?? '')),
            'address' => sanitize_textarea_field((string) ($input['address'] ?? '')),
            'social_links' => sanitize_textarea_field((string) ($input['social_links'] ?? '')),
            'global_notice' => sanitize_textarea_field((string) ($input['global_notice'] ?? '')),
        ];
    }

    /**
     * @param array{key:string} $args
     */
    public static function renderField(array $args): void
    {
        $key = $args['key'];
        $value = (string) site_content_setting($key, '');
        $name = Settings::OPTION_NAME . '[' . esc_attr($key) . ']';

        if (in_array($key, ['address', 'social_links', 'global_notice'], true)) {
            printf(
                '<textarea class="large-text" rows="4" name="%s">%s</textarea>',
                esc_attr($name),
                esc_textarea($value)
            );
            return;
        }

        printf(
            '<input class="regular-text" type="text" name="%s" value="%s">',
            esc_attr($name),
            esc_attr($value)
        );
    }

    public static function renderPage(): void
    {
        if (! current_user_can('manage_options')) {
            return;
        }

        echo '<div class="wrap">';
        echo '<h1>' . esc_html__('Site Content', 'site-content') . '</h1>';
        echo '<form method="post" action="options.php">';
        settings_fields('site_content');
        do_settings_sections('site-content');
        submit_button();
        echo '</form>';
        echo '</div>';
    }
}
