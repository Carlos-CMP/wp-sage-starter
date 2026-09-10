@php
  $sectionClass = $variant === 'muted' ? 'bg-[var(--color-surface-muted)]' : 'bg-[var(--color-text)] text-white';
@endphp

<section class="{{ $sectionClass }} py-14 md:py-20">
  <div class="mx-auto max-w-4xl px-6 text-center">
    @if ($title)
      <h2 class="text-3xl font-semibold md:text-4xl">{!! wp_kses_post($title) !!}</h2>
    @endif

    @if ($text)
      <div class="mx-auto mt-5 max-w-2xl leading-7 opacity-85">{!! wp_kses_post($text) !!}</div>
    @endif

    @if (($primaryCtaLabel && $primaryCtaUrl) || ($secondaryCtaLabel && $secondaryCtaUrl))
      <div class="mt-8 flex flex-wrap justify-center gap-3">
        @if ($primaryCtaLabel && $primaryCtaUrl)
          <a class="inline-flex items-center justify-center rounded-md bg-[var(--color-accent)] px-5 py-3 font-medium text-white" href="{{ esc_url($primaryCtaUrl) }}">{!! wp_kses_post($primaryCtaLabel) !!}</a>
        @endif
        @if ($secondaryCtaLabel && $secondaryCtaUrl)
          <a class="inline-flex items-center justify-center rounded-md border border-current px-5 py-3 font-medium" href="{{ esc_url($secondaryCtaUrl) }}">{!! wp_kses_post($secondaryCtaLabel) !!}</a>
        @endif
      </div>
    @endif
  </div>
</section>
