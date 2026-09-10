@extends('layouts.app')

@section('content')
  <section class="bg-[var(--color-surface)] py-12">
    <div class="mx-auto max-w-3xl px-6">
      @while(have_posts()) @php(the_post())
        @includeFirst(['partials.content-single-' . get_post_type(), 'partials.content-single'])
      @endwhile
    </div>
  </section>
@endsection
