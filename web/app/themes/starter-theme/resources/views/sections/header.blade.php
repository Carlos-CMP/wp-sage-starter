<header class="border-b border-[var(--color-border)] bg-[var(--color-surface)]">
  @if ($globalNotice)
    <div class="bg-[var(--color-brand-deep)] px-6 py-2 text-center text-sm font-medium text-white">
      {!! wp_kses_post($globalNotice) !!}
    </div>
  @endif

  <div class="mx-auto flex max-w-6xl items-center justify-between gap-6 px-6 py-6">
    <a class="flex min-w-0 items-center gap-3 text-lg font-bold text-[var(--color-text)]" href="{{ esc_url(home_url('/')) }}">
      @if ($siteLogo)
        <img class="h-9 w-auto" src="{{ esc_url($siteLogo) }}" alt="{{ esc_attr($siteName) }}" onerror="this.replaceWith(Object.assign(document.createElement('span'), {className: 'truncate', textContent: this.alt}))">
      @else
        <span class="truncate">{{ $siteName }}</span>
      @endif
    </a>

    @if (has_nav_menu('primary_navigation'))
      <nav class="text-sm font-bold text-[var(--color-text)]" aria-label="{{ esc_attr(wp_get_nav_menu_name('primary_navigation')) }}">
        {!! wp_nav_menu([
          'theme_location' => 'primary_navigation',
          'menu_class' => 'flex flex-wrap items-center justify-end gap-6',
          'container' => false,
          'echo' => false,
        ]) !!}
      </nav>
    @endif
  </div>
</header>
