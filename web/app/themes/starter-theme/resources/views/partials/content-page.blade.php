<div class="wp-content flex flex-1 flex-col">
  @php(the_content())
</div>

@if ($pagination())
  <nav class="starter-container mt-8" aria-label="{{ esc_attr__('Page', 'starter-theme') }}">
    {!! $pagination !!}
  </nav>
@endif
