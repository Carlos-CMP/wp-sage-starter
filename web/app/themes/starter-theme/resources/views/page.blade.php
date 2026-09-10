@extends('layouts.app')

@section('content')
  @while(have_posts()) @php(the_post())
    <article @php(post_class())>
      @include('partials.content-page')
    </article>
  @endwhile
@endsection
