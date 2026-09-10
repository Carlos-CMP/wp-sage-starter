<?php
/**
 * Plugin Name: Site Content
 * Description: Content and domain configuration boundary for the starter.
 * Version: 1.0.0
 * Requires PHP: 8.3
 * Author: Project Team
 * Text Domain: site-content
 */

declare(strict_types=1);

if (! defined('ABSPATH')) {
    exit;
}

spl_autoload_register(static function (string $class): void {
    $prefix = 'SiteContent\\';

    if (! str_starts_with($class, $prefix)) {
        return;
    }

    $relative = str_replace('\\', DIRECTORY_SEPARATOR, substr($class, strlen($prefix)));
    $path = __DIR__ . DIRECTORY_SEPARATOR . 'src' . DIRECTORY_SEPARATOR . $relative . '.php';

    if (is_readable($path)) {
        require_once $path;
    }
});

if (! function_exists('site_content_setting')) {
    function site_content_setting(string $key, mixed $default = null): mixed
    {
        return SiteContent\Support\Settings::get($key, $default);
    }
}

add_action('plugins_loaded', static function (): void {
    SiteContent\Plugin::boot();
});
