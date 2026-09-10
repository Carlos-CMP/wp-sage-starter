<?php

use function Roots\view;

$data = [
    'title' => $attributes['title'] ?? '',
    'text' => $attributes['text'] ?? '',
    'imageId' => isset($attributes['imageId']) ? (int) $attributes['imageId'] : 0,
    'imageUrl' => $attributes['imageUrl'] ?? '',
    'imageAlt' => $attributes['imageAlt'] ?? '',
    'imagePosition' => in_array($attributes['imagePosition'] ?? 'right', ['left', 'right'], true) ? $attributes['imagePosition'] : 'right',
    'ctaLabel' => $attributes['ctaLabel'] ?? '',
    'ctaUrl' => $attributes['ctaUrl'] ?? '',
    'variant' => in_array($attributes['variant'] ?? 'default', ['default', 'muted'], true) ? $attributes['variant'] : 'default',
];

echo view('blocks.text-image.component', $data)->render();
