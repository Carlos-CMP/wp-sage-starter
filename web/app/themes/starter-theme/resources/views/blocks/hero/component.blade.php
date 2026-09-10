@php
  $sectionClass = $variant === 'muted' ? 'bg-[var(--color-surface-muted)]' : 'bg-[var(--color-surface)]';
  $innerClass = $alignment === 'center' ? 'text-center mx-auto' : '';
@endphp

<section class="{{ $sectionClass }} py-16 md:py-24">
  <div class="mx-auto grid max-w-6xl gap-10 px-6 md:grid-cols-[1.1fr_0.9fr] md:items-center">
    <div class="{{ $innerClass }}">
      @if ($eyebrow)
        <p class="mb-4 text-sm font-semibold uppercase tracking-wide text-[var(--color-accent)]">{!! wp_kses_post($eyebrow) !!}</p>
      @endif

      @if ($title)
        <h1 class="text-4xl font-semibold leading-tight text-[var(--color-text)] md:text-6xl">{!! wp_kses_post($title) !!}</h1>
      @endif

      @if ($text)
        <div class="mt-5 text-lg leading-8 text-[var(--color-text-muted)]">{!! wp_kses_post($text) !!}</div>
      @endif

      @if (($primaryCtaLabel && $primaryCtaUrl) || ($secondaryCtaLabel && $secondaryCtaUrl))
        <div class="mt-8 flex flex-wrap gap-3 {{ $alignment === 'center' ? 'justify-center' : '' }}">
          @if ($primaryCtaLabel && $primaryCtaUrl)
            <a class="inline-flex items-center justify-center rounded-md bg-[var(--color-accent)] px-5 py-3 font-medium text-white" href="{{ esc_url($primaryCtaUrl) }}">{!! wp_kses_post($primaryCtaLabel) !!}</a>
          @endif
          @if ($secondaryCtaLabel && $secondaryCtaUrl)
            <a class="inline-flex items-center justify-center rounded-md border border-[var(--color-border)] px-5 py-3 font-medium text-[var(--color-text)]" href="{{ esc_url($secondaryCtaUrl) }}">{!! wp_kses_post($secondaryCtaLabel) !!}</a>
          @endif
        </div>
      @endif
    </div>

    @if ($imageId)
      {!! wp_get_attachment_image($imageId, 'large', false, ['class' => 'w-full rounded-lg object-cover']) !!}
    @elseif ($imageUrl)
      <img class="w-full rounded-lg object-cover" src="{{ esc_url($imageUrl) }}" alt="{{ esc_attr($imageAlt) }}">
    @endif
  </div>
</section>
