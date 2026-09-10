<?php

declare(strict_types=1);

namespace SiteContent\Support;

final class Config
{
    /**
     * @return array<string, mixed>
     */
    public static function features(): array
    {
        $features = require dirname(__DIR__, 2) . '/config/features.php';

        return is_array($features) ? $features : [];
    }

    public static function feature(string $key, bool $default = false): bool
    {
        $features = self::features();

        return isset($features[$key]) ? (bool) $features[$key] : $default;
    }
}
