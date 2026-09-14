<footer class="border-t border-[var(--color-border)] bg-[var(--color-text)] text-white">
  <div class="mx-auto grid max-w-6xl gap-8 px-6 py-10 md:grid-cols-[1fr_auto]">
    <div>
      <a class="font-bold text-white" href="{{ esc_url(home_url('/')) }}">
        {{ $siteName }}
      </a>

      @if ($siteAddress || $sitePhone || $siteEmail)
        <address class="mt-4 space-y-1 text-sm not-italic text-white/70">
          @if ($siteAddress)
            <div>{!! nl2br(esc_html($siteAddress)) !!}</div>
          @endif
          @if ($sitePhone)
            <div><a href="tel:{{ esc_attr(preg_replace('/[^0-9+]/', '', $sitePhone)) }}">{{ $sitePhone }}</a></div>
          @endif
          @if ($siteEmail)
            <div><a href="mailto:{{ esc_attr($siteEmail) }}">{{ $siteEmail }}</a></div>
          @endif
        </address>
      @endif
    </div>

    @if (has_nav_menu('footer_navigation'))
      <nav class="text-sm font-medium text-white/70" aria-label="{{ esc_attr(wp_get_nav_menu_name('footer_navigation')) }}">
        {!! wp_nav_menu([
          'theme_location' => 'footer_navigation',
          'menu_class' => 'flex flex-wrap gap-4 md:justify-end',
          'container' => false,
          'echo' => false,
        ]) !!}
      </nav>
    @endif
  </div>

  <div class="border-t border-white/10 px-6 py-4 text-center text-xs text-white/60">
    &copy; {{ date('Y') }} {{ $siteName }}
  </div>
</footer>
