<?php

declare(strict_types=1);

namespace SiteContent\Support;

final class Settings
{
    public const OPTION_NAME = 'site_content_settings';

    public static function get(string $key, mixed $default = null): mixed
    {
        $settings = get_option(self::OPTION_NAME, []);

        if (! is_array($settings)) {
            return $default;
        }

        $value = $settings[$key] ?? $default;

        return apply_filters('site_content_setting', $value, $key, $default);
    }
}
