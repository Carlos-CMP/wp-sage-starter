<?php

declare(strict_types=1);

namespace SiteContent\Filters;

final class ExampleFilter
{
    public static function register(): void
    {
        add_filter('site_content_setting', [self::class, 'filterSetting'], 10, 3);
    }

    public static function filterSetting(mixed $value, string $key, mixed $default): mixed
    {
        return $value;
    }
}
