@extends('layouts.app')

@section('content')
  <section class="bg-[var(--color-surface)] py-12">
    <div class="mx-auto max-w-4xl px-6">
      @include('partials.page-header')

      @if (! have_posts())
        <div class="rounded-md border border-[var(--color-border)] bg-[var(--color-surface-muted)] p-6">
          <p class="text-[var(--color-text-muted)]">{{ __('No content found.', 'starter-theme') }}</p>
          <div class="mt-4">
            {!! get_search_form(false) !!}
          </div>
        </div>
      @endif

      <div class="space-y-8">
        @while(have_posts()) @php(the_post())
          @includeFirst(['partials.content-' . get_post_type(), 'partials.content'])
        @endwhile
      </div>

      <div class="mt-10">
        {!! get_the_posts_navigation() !!}
      </div>
    </div>
  </section>
@endsection
