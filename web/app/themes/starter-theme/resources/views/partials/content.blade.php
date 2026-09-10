<article @php(post_class('rounded-md border border-[var(--color-border)] bg-[var(--color-surface)] p-6'))>
  <header>
    <h2 class="text-2xl font-semibold text-[var(--color-text)]">
      <a href="{{ esc_url(get_permalink()) }}">
        {!! wp_kses_post($title) !!}
      </a>
    </h2>

    @include('partials.entry-meta')
  </header>

  <div class="mt-4 leading-7 text-[var(--color-text-muted)]">
    @php(the_excerpt())
  </div>
</article>
