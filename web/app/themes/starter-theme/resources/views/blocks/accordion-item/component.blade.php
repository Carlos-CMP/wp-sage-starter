<details class="py-5">
  <summary class="cursor-pointer text-lg font-medium text-[var(--color-text)]">
    {!! wp_kses_post($question) !!}
  </summary>
  <div class="mt-3 leading-7 text-[var(--color-text-muted)]">
    {!! $content !!}
  </div>
</details>
