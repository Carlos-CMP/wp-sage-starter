<?php

use function Roots\view;

$data = [
    'title' => $attributes['title'] ?? '',
    'text' => $attributes['text'] ?? '',
    'primaryCtaLabel' => $attributes['primaryCtaLabel'] ?? '',
    'primaryCtaUrl' => $attributes['primaryCtaUrl'] ?? '',
    'secondaryCtaLabel' => $attributes['secondaryCtaLabel'] ?? '',
    'secondaryCtaUrl' => $attributes['secondaryCtaUrl'] ?? '',
    'variant' => in_array($attributes['variant'] ?? 'default', ['default', 'muted'], true) ? $attributes['variant'] : 'default',
];

echo view('blocks.cta.component', $data)->render();
