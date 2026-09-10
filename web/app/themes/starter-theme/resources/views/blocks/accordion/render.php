<?php

use function Roots\view;

$data = [
    'title' => $attributes['title'] ?? '',
    'content' => $content ?? '',
    'variant' => in_array($attributes['variant'] ?? 'default', ['default', 'muted'], true) ? $attributes['variant'] : 'default',
];

echo view('blocks.accordion.component', $data)->render();
