import js from '@eslint/js';

export default [
  {
    ignores: ['node_modules/**', 'public/**'],
  },
  js.configs.recommended,
  {
    files: ['resources/js/**/*.js', 'vite.config.js'],
    languageOptions: {
      ecmaVersion: 'latest',
      sourceType: 'module',
      globals: {
        process: 'readonly',
      },
    },
  },
];
