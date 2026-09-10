@extends('layouts.app')

@section('content')
  <section class="bg-[var(--color-surface)] py-12">
    <div class="mx-auto max-w-4xl px-6">
      @include('partials.page-header')

      <div class="mt-6">
        {!! get_search_form(false) !!}
      </div>

      @if (! have_posts())
        <div class="mt-8 rounded-md border border-[var(--color-border)] bg-[var(--color-surface-muted)] p-6">
          <p class="text-[var(--color-text-muted)]">{{ __('No results were found.', 'starter-theme') }}</p>
        </div>
      @endif

      <div class="mt-8 space-y-8">
        @while(have_posts()) @php(the_post())
          @include('partials.content-search')
        @endwhile
      </div>

      <div class="mt-10">
        {!! get_the_posts_navigation() !!}
      </div>
    </div>
  </section>
@endsection
