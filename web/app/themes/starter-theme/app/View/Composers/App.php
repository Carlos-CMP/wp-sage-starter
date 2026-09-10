<?php

namespace App\View\Composers;

use Roots\Acorn\View\Composer;

class App extends Composer
{
    /**
     * List of views served by this composer.
     *
     * @var array
     */
    protected static $views = [
        '*',
    ];

    /**
     * Retrieve the site name.
     */
    public function siteName(): string
    {
        return get_bloginfo('name', 'display');
    }

    public function siteLogo(): string
    {
        return function_exists('site_content_setting')
            ? (string) site_content_setting('logo', '')
            : '';
    }

    public function sitePhone(): string
    {
        return function_exists('site_content_setting')
            ? (string) site_content_setting('phone', '')
            : '';
    }

    public function siteEmail(): string
    {
        return function_exists('site_content_setting')
            ? (string) site_content_setting('email', '')
            : '';
    }

    public function siteAddress(): string
    {
        return function_exists('site_content_setting')
            ? (string) site_content_setting('address', '')
            : '';
    }

    public function globalNotice(): string
    {
        return function_exists('site_content_setting')
            ? (string) site_content_setting('global_notice', '')
            : '';
    }
}
