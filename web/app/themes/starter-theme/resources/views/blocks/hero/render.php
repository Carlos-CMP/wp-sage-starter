<?php

use function Roots\view;

$data = [
    'eyebrow' => $attributes['eyebrow'] ?? '',
    'title' => $attributes['title'] ?? '',
    'text' => $attributes['text'] ?? '',
    'primaryCtaLabel' => $attributes['primaryCtaLabel'] ?? '',
    'primaryCtaUrl' => $attributes['primaryCtaUrl'] ?? '',
    'secondaryCtaLabel' => $attributes['secondaryCtaLabel'] ?? '',
    'secondaryCtaUrl' => $attributes['secondaryCtaUrl'] ?? '',
    'imageId' => isset($attributes['imageId']) ? (int) $attributes['imageId'] : 0,
    'imageUrl' => $attributes['imageUrl'] ?? '',
    'imageAlt' => $attributes['imageAlt'] ?? '',
    'alignment' => in_array($attributes['alignment'] ?? 'left', ['left', 'center'], true) ? $attributes['alignment'] : 'left',
    'variant' => in_array($attributes['variant'] ?? 'default', ['default', 'muted'], true) ? $attributes['variant'] : 'default',
];

echo view('blocks.hero.component', $data)->render();
