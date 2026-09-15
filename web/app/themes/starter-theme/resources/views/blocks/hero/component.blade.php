@php
  $sectionClass = $variant === 'muted' ? 'bg-[var(--color-surface-muted)]' : 'bg-[var(--color-surface)]';
  $innerClass = $alignment === 'center' ? 'text-center mx-auto' : '';
@endphp

<section class="{{ $sectionClass }} flex flex-1 items-center py-16 md:py-24">
  <div class="mx-auto grid max-w-6xl gap-10 px-6 md:grid-cols-[1.1fr_0.9fr] md:items-center">
    <div class="{{ $innerClass }}">
      @if ($eyebrow)
        <p class="mb-4 text-sm font-bold uppercase text-[var(--color-accent)]">{!! wp_kses_post($eyebrow) !!}</p>
      @endif

      @if ($title)
        <h1 class="max-w-4xl text-5xl font-bold leading-[0.98] text-[var(--color-text)] md:text-7xl">{!! wp_kses_post($title) !!}</h1>
      @endif

      @if ($text)
        <div class="mt-6 max-w-2xl text-lg leading-8 text-[var(--color-text-muted)]">{!! wp_kses_post($text) !!}</div>
      @endif

      @if (($primaryCtaLabel && $primaryCtaUrl) || ($secondaryCtaLabel && $secondaryCtaUrl))
        <div class="mt-8 flex flex-wrap gap-3 {{ $alignment === 'center' ? 'justify-center' : '' }}">
          @if ($primaryCtaLabel && $primaryCtaUrl)
            <a class="inline-flex items-center justify-center rounded-[var(--radius-control)] bg-[var(--color-accent)] px-6 py-3 font-bold text-white transition hover:bg-[var(--color-accent-hover)]" href="{{ esc_url($primaryCtaUrl) }}">{!! wp_kses_post($primaryCtaLabel) !!}</a>
          @endif
          @if ($secondaryCtaLabel && $secondaryCtaUrl)
            <a class="inline-flex items-center justify-center rounded-[var(--radius-control)] border border-[var(--color-text)] px-6 py-3 font-bold text-[var(--color-text)] transition hover:bg-[var(--color-text)] hover:text-white" href="{{ esc_url($secondaryCtaUrl) }}">{!! wp_kses_post($secondaryCtaLabel) !!}</a>
          @endif
        </div>
      @endif
    </div>

    @if ($imageId)
      {!! wp_get_attachment_image($imageId, 'large', false, ['class' => 'w-full rounded-[var(--radius-control)] object-cover']) !!}
    @elseif ($imageUrl)
      <img class="w-full rounded-[var(--radius-control)] object-cover" src="{{ esc_url($imageUrl) }}" alt="{{ esc_attr($imageAlt) }}">
    @endif
  </div>
</section>
