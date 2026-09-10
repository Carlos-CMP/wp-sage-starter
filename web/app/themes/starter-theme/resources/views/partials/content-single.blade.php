<article @php(post_class('h-entry'))>
  <header class="mb-8">
    <h1 class="p-name text-4xl font-semibold leading-tight text-[var(--color-text)]">
      {!! wp_kses_post($title) !!}
    </h1>

    @include('partials.entry-meta')
  </header>

  <div class="e-content wp-content leading-7 text-[var(--color-text)]">
    @php(the_content())
  </div>

  @if ($pagination())
    <footer class="mt-8">
      <nav aria-label="{{ esc_attr__('Page', 'starter-theme') }}">
        {!! $pagination !!}
      </nav>
    </footer>
  @endif

  @php(comments_template())
</article>
