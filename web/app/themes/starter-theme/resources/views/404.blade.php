@extends('layouts.app')

@section('content')
  <section class="bg-[var(--color-surface)] py-20">
    <div class="mx-auto max-w-2xl px-6 text-center">
      <p class="text-sm font-semibold uppercase tracking-wide text-[var(--color-accent)]">{{ __('404', 'starter-theme') }}</p>
      <h1 class="mt-3 text-4xl font-semibold text-[var(--color-text)]">{{ __('Page not found', 'starter-theme') }}</h1>
      <p class="mt-4 text-[var(--color-text-muted)]">{{ __('The page you are trying to view does not exist.', 'starter-theme') }}</p>

      <div class="mt-8 text-left">
        {!! get_search_form(false) !!}
      </div>
    </div>
  </section>
@endsection
