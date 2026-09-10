@php
  $sectionClass = $variant === 'muted' ? 'bg-[var(--color-surface-muted)]' : 'bg-[var(--color-surface)]';
  $imageClass = $imagePosition === 'left' ? 'md:order-first' : 'md:order-last';
@endphp

<section class="{{ $sectionClass }} py-14 md:py-20">
  <div class="mx-auto grid max-w-6xl gap-10 px-6 md:grid-cols-2 md:items-center">
    <div>
      @if ($title)
        <h2 class="text-3xl font-semibold text-[var(--color-text)] md:text-4xl">{!! wp_kses_post($title) !!}</h2>
      @endif

      @if ($text)
        <div class="mt-5 leading-7 text-[var(--color-text-muted)]">{!! wp_kses_post($text) !!}</div>
      @endif

      @if ($ctaLabel && $ctaUrl)
        <a class="mt-7 inline-flex items-center rounded-md border border-[var(--color-border)] px-5 py-3 font-medium text-[var(--color-text)]" href="{{ esc_url($ctaUrl) }}">{!! wp_kses_post($ctaLabel) !!}</a>
      @endif
    </div>

    <div class="{{ $imageClass }}">
      @if ($imageId)
        {!! wp_get_attachment_image($imageId, 'large', false, ['class' => 'w-full rounded-lg object-cover']) !!}
      @elseif ($imageUrl)
        <img class="w-full rounded-lg object-cover" src="{{ esc_url($imageUrl) }}" alt="{{ esc_attr($imageAlt) }}">
      @endif
    </div>
  </div>
</section>
