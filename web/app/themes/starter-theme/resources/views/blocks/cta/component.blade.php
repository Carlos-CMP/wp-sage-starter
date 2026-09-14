@php
  $sectionClass = $variant === 'muted' ? 'bg-[var(--color-surface-muted)] text-[var(--color-text)]' : 'bg-[var(--color-brand-deep)] text-white';
@endphp

<section class="{{ $sectionClass }} py-14 md:py-20">
  <div class="mx-auto max-w-4xl px-6 text-center">
    @if ($title)
      <h2 class="text-4xl font-bold md:text-5xl">{!! wp_kses_post($title) !!}</h2>
    @endif

    @if ($text)
      <div class="mx-auto mt-5 max-w-2xl leading-7 opacity-85">{!! wp_kses_post($text) !!}</div>
    @endif

    @if (($primaryCtaLabel && $primaryCtaUrl) || ($secondaryCtaLabel && $secondaryCtaUrl))
      <div class="mt-8 flex flex-wrap justify-center gap-3">
        @if ($primaryCtaLabel && $primaryCtaUrl)
          <a class="inline-flex items-center justify-center rounded-[var(--radius-control)] bg-[var(--color-accent)] px-6 py-3 font-bold text-white transition hover:bg-[var(--color-accent-hover)]" href="{{ esc_url($primaryCtaUrl) }}">{!! wp_kses_post($primaryCtaLabel) !!}</a>
        @endif
        @if ($secondaryCtaLabel && $secondaryCtaUrl)
          <a class="inline-flex items-center justify-center rounded-[var(--radius-control)] border border-current px-6 py-3 font-bold transition hover:bg-white hover:text-[var(--color-brand-deep)]" href="{{ esc_url($secondaryCtaUrl) }}">{!! wp_kses_post($secondaryCtaLabel) !!}</a>
        @endif
      </div>
    @endif
  </div>
</section>
