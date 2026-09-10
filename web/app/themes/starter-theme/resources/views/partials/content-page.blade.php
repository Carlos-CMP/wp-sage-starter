<div class="wp-content">
  @php(the_content())
</div>

@if ($pagination())
  <nav class="starter-container mt-8" aria-label="{{ esc_attr__('Page', 'starter-theme') }}">
    {!! $pagination !!}
  </nav>
@endif
