<form role="search" method="get" class="search-form" action="{{ home_url('/') }}">
  <label>
    <span class="sr-only">
      {{ _x('Search for:', 'label', 'starter-theme') }}
    </span>

    <input
      type="search"
      placeholder="{!! esc_attr_x('Search &hellip;', 'placeholder', 'starter-theme') !!}"
      value="{!! get_search_query() !!}"
      name="s"
    >
  </label>

  <button>{{ _x('Search', 'submit button', 'starter-theme') }}</button>
</form>
