@php
  $sectionClass = $variant === 'muted' ? 'bg-[var(--color-surface-muted)]' : 'bg-[var(--color-surface)]';
@endphp

<section class="{{ $sectionClass }} py-14 md:py-20">
  <div class="mx-auto max-w-3xl px-6">
    @if ($title)
      <h2 class="text-3xl font-semibold text-[var(--color-text)] md:text-4xl">{!! wp_kses_post($title) !!}</h2>
    @endif

    <div class="mt-8 divide-y divide-[var(--color-border)]">
      {!! $content !!}
    </div>
  </div>
</section>
