<?php

use function Roots\view;

$data = [
    'question' => $attributes['question'] ?? '',
    'content' => $content ?? '',
];

echo view('blocks.accordion-item.component', $data)->render();
