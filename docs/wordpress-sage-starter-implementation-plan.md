# WordPress Sage Starter Pack — Implementation Plan

## 1. Goal

Create a reusable WordPress starter pack for real marketing websites, optimized for fast project bootstrap, consistent architecture, modular Gutenberg components, easy design-system replacement, and execution by a lightweight spec-driven development harness.

The starter must be a **template of origin**, not a framework that later synchronizes updates into downstream projects.

---

## 2. Core Principles

- Use **Bedrock + Sage** as the project foundation.
- Use **Tailwind CSS** as the styling system.
- Use **ACF Free** only.
- Use **Gutenberg** as the editor experience.
- Build blocks as **modular components**.
- Keep business/content logic out of the theme where possible.
- Centralize site content logic in a dedicated `site-content` plugin.
- Keep the design system replaceable through project-level tokens/configuration.
- Favor conventions that are explicit and easy for an agent/harness to interpret.
- Prefer the minimum viable infrastructure needed for real production projects.
- Avoid unnecessary third-party plugins and dependencies.
- Keep SEO, analytics, external APIs, forms, caching, and deployment extensible but minimally coupled.
- Make local development reproducible.
- Do not include Docker in `v1.0.0` unless a concrete project need requires it.
- Support multilingual projects without coupling to a specific multilingual plugin.
- Use semantic versioning for the starter itself.
- Downstream projects evolve independently after creation.

---

## 3. Target Stack

| Area | Technology |
|---|---|
| CMS | WordPress |
| Project foundation | Bedrock |
| Theme | Sage |
| Styling | Tailwind CSS |
| Editor | Gutenberg |
| Custom fields | ACF Free |
| Backend language | PHP |
| Package management | Composer + npm |
| CLI | WP-CLI |
| Local environment | LocalWP recommended; native/manual setup supported |
| CI | Minimal validation template |
| Versioning | Semantic Versioning |
| Documentation | Markdown |
| Harness compatibility | Spec-driven Markdown tasks |

---

## 4. Minimum Runtime Requirements

Declare and validate minimum supported versions.

```text
PHP >= 8.3
Composer >= 2.x
Node.js = current LTS
WordPress = latest stable release at starter creation time
Sage = current stable release at starter creation time
Bedrock = current stable release at starter creation time
```

PHP 8.3 is required for `v1.0.0` so the starter can use the current stable Bedrock release.

The exact resolved versions must be pinned in project dependency files.

Resolve Bedrock, Sage, WordPress, PHP package, and Node package versions when creating `v1.0.0`, then commit the generated lock files. Do not leave broad dependency ranges as the only reproducibility mechanism.

---

## 5. Repository Structure

```text
wp-starter/
├─ app/
├─ config/
├─ web/
│  └─ app/
│     ├─ themes/
│     │  └─ starter-theme/
│     └─ plugins/
│        └─ site-content/
├─ scripts/
├─ docs/
├─ .github/
├─ .env.example
├─ AGENTS.md
├─ CHANGELOG.md
├─ README.md
├─ composer.json
└─ implementation-plan.md
```

The repository must remain understandable from the filesystem without requiring hidden conventions.

---

## 6. Architecture

### 6.1 Responsibility split

```text
Bedrock
├─ environment/configuration
├─ dependency management
└─ WordPress bootstrap

Sage theme
├─ presentation
├─ Blade templates
├─ Gutenberg block rendering
├─ Tailwind
├─ navigation rendering
└─ visual components

site-content plugin
├─ CPTs
├─ taxonomies
├─ ACF field registration
├─ site settings
├─ functional feature flags
├─ hooks/filters
└─ reusable content/domain behavior
```

### 6.2 Dependency rule

The theme must not contain project content models that belong in `site-content`.

The `site-content` plugin must not depend on theme-specific markup or styling.

---

## 7. Theme Structure

Recommended Sage theme structure:

```text
starter-theme/
├─ app/
│  ├─ Providers/
│  ├─ View/
│  └─ setup.php
├─ resources/
│  ├─ views/
│  │  ├─ blocks/
│  │  ├─ components/
│  │  ├─ layouts/
│  │  └─ partials/
│  ├─ css/
│  ├─ js/
│  └─ design-system/
├─ public/
├─ tailwind.config.*
├─ vite.config.*
└─ theme.json
```

---

## 8. Modular Gutenberg Block Convention

Every block must be self-contained and follow the same convention.

```text
resources/views/blocks/
└─ hero/
   ├─ block.json
   ├─ fields.php
   ├─ render.php
   ├─ component.blade.php
   └─ README.md
```

### Responsibilities

- `block.json`
  - Gutenberg metadata
  - block name
  - category
  - supports
  - assets
  - render registration metadata

- `fields.php`
  - optional ACF Free field-group registration for simple non-repeating fields
  - no markup
  - no business logic

- `render.php`
  - input normalization
  - data preparation
  - render delegation
  - no large markup structures

- `component.blade.php`
  - presentation only
  - consume prepared data
  - consume design-system tokens/classes
  - no direct persistence logic

- `README.md`
  - short contract
  - expected fields
  - variants
  - accessibility considerations

### Rules

- Do not mix ACF registration and HTML.
- Do not use ACF Pro-only block APIs, repeaters, flexible content, clone fields, or options pages.
- Use native Gutenberg block attributes and `InnerBlocks` for repeated/nested content.
- Do not place business logic in Blade.
- Do not hardcode visual tokens inside components where a design token exists.
- Each new block must follow the same folder contract.
- Blocks must be independently removable.

---

## 9. Base Gutenberg Components

Implement 4 components for `v1.0.0`.

Document the remaining 6 components as `v1.1+` backlog so the starter reaches a stable first release before expanding the block library.

### 9.1 Hero

Fields:

```text
eyebrow
title
text
primary_cta_label
primary_cta_url
secondary_cta_label
secondary_cta_url
image
alignment
variant
```

### 9.2 Text + Image

Fields:

```text
title
text
image
image_position
cta_label
cta_url
variant
```

### 9.3 Cards Grid (`v1.1+` backlog)

Fields:

```text
title
intro
card child blocks via InnerBlocks
  title
  text
  image
  url
columns
variant
```

### 9.4 CTA

Fields:

```text
title
text
cta_label
cta_url
secondary_cta_label
secondary_cta_url
variant
```

### 9.5 Accordion / FAQ

Fields:

```text
title
FAQ item child blocks via InnerBlocks
  question
  answer
variant
```

Requirements:

- accessible keyboard interaction
- semantic buttons
- proper expanded/collapsed state
- minimal JS

### 9.6 Testimonials (`v1.1+` backlog)

Fields:

```text
title
testimonial child blocks via InnerBlocks
  quote
  person_name
  role
  company
  image
variant
```

### 9.7 Logos / Partners (`v1.1+` backlog)

Fields:

```text
title
logo child blocks via InnerBlocks
  image
  alt
  url
columns
variant
```

### 9.8 Stats / Metrics (`v1.1+` backlog)

Fields:

```text
title
stat child blocks via InnerBlocks
  value
  label
  description
variant
```

### 9.9 Feature List (`v1.1+` backlog)

Fields:

```text
title
intro
feature child blocks via InnerBlocks
  title
  text
  icon
variant
```

### 9.10 Contact / Form Section (`v1.1+` backlog)

Fields:

```text
title
text
form_identifier
contact_details
variant
```

The block must not depend on a specific forms plugin.

---

## 10. ACF Free Strategy

Use ACF Free only.

### Requirements

- Register field groups programmatically where practical.
- Keep field definitions version controlled.
- Avoid ACF Pro-only features.
- Do not use ACF repeaters, flexible content, clone fields, ACF Blocks, or any paid-only field type.
- Do not use ACF Options Pages.
- Global settings must use the native WordPress Settings API.
- Gutenberg block integration must avoid assumptions that require ACF Pro-only block APIs.

If a specific block feature cannot be implemented with ACF Free alone, use native Gutenberg APIs, block attributes, `InnerBlocks`, or a native WordPress fallback rather than adding ACF Pro.

---

## 11. Design System

The starter must ship with a minimal default design system that is intentionally easy to replace.

### 11.1 Tokens

Centralize:

```text
colors
font families
font sizes
font weights
line heights
spacing
container widths
breakpoints
border radius
shadows
z-index
```

### 11.2 Rules

- Components consume tokens.
- Components do not hardcode project branding.
- New projects replace tokens/configuration, not component internals.
- Default design must be neutral.

### 11.3 Suggested structure

```text
resources/design-system/
├─ tokens.css
├─ typography.css
├─ utilities.css
└─ README.md
```

And Tailwind configuration must expose those tokens.

---

## 12. Project-Level Configuration

Create a small configuration layer for each generated project.

Suggested structure:

```text
config/project.php
resources/design-system/project-tokens.css
```

Configuration must allow:

```text
project name
brand colors
typography
logo references
breakpoints
spacing
contact data
social links
feature flags
enabled CPTs
enabled taxonomies
enabled components
```

Do not store secrets here.

---

## 13. Feature Flags

Provide explicit flags for optional starter capabilities.

Example:

```php
return [
    'features' => [
        'example_post_type' => false,
        'example_taxonomy' => false,
        'demo_page' => true,
        'demo_content' => true,
    ],
];
```

Rules:

- Flags must be version controlled.
- Flags must not contain secrets.
- Disabled features must not execute unnecessary runtime logic.

---

## 14. `site-content` Plugin Structure

The `site-content` plugin is part of `v1.0.0`, but only as a minimal architectural boundary.

```text
site-content/
├─ src/
│  ├─ PostTypes/
│  ├─ Taxonomies/
│  ├─ Fields/
│  ├─ Settings/
│  ├─ Hooks/
│  ├─ Filters/
│  └─ Support/
├─ config/
├─ site-content.php
└─ README.md
```

### Include

- one example CPT
- one example taxonomy
- both disabled by default
- one Settings API implementation
- one hook/filter example

The examples exist as extension patterns, not business features.

Do not add project-specific content models to `v1.0.0`.

---

## 15. Global Site Settings

Because ACF Free does not provide Options Pages, implement a custom admin settings page using the WordPress Settings API.

Minimum settings:

```text
logo
phone
email
address
social links
global notice
```

Requirements:

- sanitize all values
- use native WordPress APIs
- make settings available to Sage views through a small helper/service
- no third-party settings plugin

---

## 16. Navigation

Provide minimal navigation support.

Required menus:

```text
primary
footer
```

Requirements:

- site header
- primary navigation
- site footer
- footer navigation
- Blade rendering
- active/current state
- accessible mobile navigation
- keyboard support
- semantic markup
- architecture must allow future mega menu support without implementing one

---

## 17. Page Layouts

Keep layouts minimal.

Required:

```text
default
full-width
landing
```

Blocks must not depend on one layout.

For `v1.0.0`, implement layouts as minimal Blade wrappers only; do not build an advanced layout system.

---

## 18. System Templates

Provide functional minimal templates for:

```text
404
search
archive
single
index/blog
```

These are base implementations intended to be replaced by the project design.

For `v1.0.0`, keep these templates minimal: valid content output, shared header/footer, basic empty states, and no project-specific layout assumptions.

---

## 19. Media Strategy

Provide conventions for media handling.

Requirements:

- define sensible custom image sizes
- use native responsive image support
- preserve `srcset`
- use lazy loading where appropriate
- avoid hardcoded media URLs
- provide a Sage/Blade image helper/component
- define ACF image return conventions consistently
- remain CDN-compatible

---

## 20. Accessibility Baseline

All starter components must be accessible by default.

Minimum requirements:

- semantic HTML
- meaningful heading hierarchy
- visible focus
- keyboard navigation
- labels for form controls
- meaningful alt text handling
- avoid unnecessary ARIA
- sufficient default contrast
- accessible accordion
- accessible mobile menu

Accessibility belongs in the component implementation, not as a later patch.

---

## 21. Performance Baseline

Implement only low-cost, high-value defaults.

Requirements:

- conditional block assets when practical
- avoid unnecessary global JS
- optimized Tailwind output
- responsive images
- lazy loading
- minimal JS for interactive components
- no heavy optimization plugins
- no runtime features enabled without use

---

## 22. SEO

Keep SEO implementation **decoupled**.

For `v1.0.0`, implement only the basics that naturally belong in theme markup.

Provide:

- correct semantic headings
- clean permalink defaults
- theme support compatible with SEO plugins
- sensible document structure
- hooks/documentation for future SEO integration
- no mandatory SEO plugin
- no project-specific schema by default

---

## 23. Analytics / Marketing

Prepare minimal extension points without coupling to a provider.

Provide:

```text
head script hook
body-open hook
footer script hook
```

Do not install GTM, GA, Meta Pixel, or cookie plugins by default.

Document event-tracking and consent integration patterns, but do not implement provider-specific behavior in `v1.0.0`.

---

## 24. Forms

Provide only a neutral convention.

For `v1.0.0`, the Contact / Form Section block is backlog, so forms are limited to documentation and shared accessible markup conventions.

Requirements:

- reusable accessible markup pattern
- clear error states
- extension hooks for external providers

Do not store submissions by default.

Do not install a forms plugin by default.

---

## 25. Multilingual Readiness

The starter must be compatible with multilingual projects without depending on WPML, Polylang, or another provider.

For `v1.0.0`, implement only WordPress-native localization basics.

Requirements:

- all theme strings translatable
- consistent text domain
- avoid hardcoded language assumptions
- use WordPress localization APIs
- navigation/configuration should support translated menus later
- plugin labels must be translatable

---

## 26. External API Convention

Keep minimal and project-driven.

Rules:

- no HTTP calls directly in templates
- external service credentials belong in `.env`
- define a service/client layer only when a project needs it
- configure timeout/error handling
- avoid building generic abstractions without a concrete project need

No active external API integration is included in the starter.

---

## 27. Logging and Errors

Use native WordPress/PHP facilities only.

Environment rules:

### Local

```text
WP_DEBUG=true
WP_DEBUG_LOG=true
WP_DEBUG_DISPLAY=true
```

### Staging

```text
WP_DEBUG=true
WP_DEBUG_LOG=true
WP_DEBUG_DISPLAY=false
```

### Production

```text
WP_DEBUG=false
WP_DEBUG_DISPLAY=false
```

Requirements:

- technical errors must not leak to production UI
- do not log secrets
- no third-party logging package by default

---

## 28. Cache Convention

Do not add Redis, Varnish, object-cache plugins, or caching libraries.

Document:

- use Transients API only when justified
- define invalidation when introducing a transient
- do not cache dynamic user-specific data without explicit reasoning

No custom cache layer is active by default.

---

## 29. Security Baseline

Use native configuration and code only.

Minimum requirements:

- environment-specific salts
- secrets in `.env`
- disable file editing from WordPress admin
- escape output
- sanitize input
- use nonces for state-changing admin/frontend actions
- use WordPress capabilities correctly
- do not expose debug information in production
- avoid committing credentials

No security plugin is installed by default.

---

## 30. Environment Configuration

Use Bedrock environment configuration.

For local development, LocalWP is the recommended reference environment.

The starter must not depend on LocalWP internals. Database credentials, URL, and paths must come from `.env`.

Required environments:

```text
local
staging
production
```

Provide:

```text
.env.example
config/environments/development.php
config/environments/staging.php
config/environments/production.php
```

The `.env.example` must document all required variables without real secrets.

---

## 31. Secrets Convention

### Version controlled

```text
feature flags
design tokens
non-sensitive project config
component config
default theme settings
```

### Never version controlled

```text
database passwords
WordPress salts
API keys
SMTP credentials
OAuth secrets
deployment credentials
third-party service secrets
```

Add explicit instructions to `AGENTS.md`.

---

## 32. Essential Plugins

Keep plugin footprint minimal.

Required dependency:

```text
Advanced Custom Fields (Free)
```

Any additional plugin must be optional and justified by a real project.

Do not install generic SEO, security, caching, forms, analytics, or multilingual plugins by default.

---

## 33. WP-CLI

WP-CLI is a core part of bootstrap automation.

Expected commands include:

```bash
wp core install
wp plugin activate
wp theme activate
wp option update
wp rewrite flush
```

Scripts must be idempotent where practical.

Re-running bootstrap should not corrupt an existing local setup.

---

## 34. Bootstrap Automation

Provide a PowerShell entry point for Windows-first development.

The `v1.0.0` bootstrap must stay minimal and deterministic.

The script should support LocalWP by reading connection details from `.env`, not by controlling LocalWP itself.

Example:

```powershell
./scripts/new-project.ps1 -Name "client-project"
```

### Responsibilities

1. validate required tooling
2. copy starter template
3. rename project identifiers
4. create `.env` from `.env.example`
5. install Composer dependencies
6. install Node dependencies
7. prepare WordPress
8. install/activate required plugins
9. activate Sage theme
10. configure base options
11. configure menus
12. run initial frontend build
13. print next-step instructions

The script must fail clearly and early when a required tool is missing.

Do not include complex demo seeding in the `v1.0.0` bootstrap script.

---

## 35. Docker (`v1.1+` conditional backlog)

Docker is not part of `v1.0.0`.

Only add Docker later if a concrete project need justifies the extra maintenance surface.

Suggested services:

```text
wordpress/php runtime
database
optional mail catcher for local development
```

Requirements:

- one `docker compose up -d` command
- no Docker dependency for projects that do not want it
- Docker config isolated under `/docker` and/or compose files
- flag or setup choice determines whether it is used

---

## 36. Demo Page

Provide a minimal development-only component showcase page.

Purpose:

- render all `v1.0.0` components
- render the site header, primary navigation, footer navigation, and site footer
- validate tokens
- validate responsive behavior
- validate accessibility
- allow quick visual QA

Rules:

- enabled in local/staging only
- disabled in production
- must not become required application content

---

## 37. Demo / Seed Data

Provide minimal optional seed commands for local/staging visual validation.

Seed may create:

```text
Home
Component Showcase
Primary menu
Footer menu
global settings
sample content for the 4 `v1.0.0` blocks
```

Requirements:

- safe to skip
- development only
- never required for production
- use WP-CLI where practical
- no example users in `v1.0.0`

---

## 38. Code Quality

Keep `v1.0.0` tooling minimal.

Include:

```text
PHP_CodeSniffer with minimal WordPress-compatible rules
ESLint
Prettier
```

Provide scripts:

```bash
npm run lint
npm run format
composer lint
```

Avoid large static-analysis/test stacks in the starter unless a real project needs them.

Do not add additional quality tools to `v1.0.0` without a concrete failure they solve.

---

## 39. Testing

Keep `v1.0.0` testing minimal.

Required:

- linting
- manual/automated smoke validation for bootstrap
- successful Sage asset build

Optional:

- PHPUnit examples for `site-content` logic once real logic exists
- Playwright E2E

Do not make PHPUnit or E2E mandatory in `v1.0.0`.

---

## 40. CI Template

Include one minimal CI template for validation only.

Recommended default:

```text
GitHub Actions
```

Pipeline:

```text
checkout
install PHP dependencies
install Node dependencies
lint
build Sage assets
```

Artifact packaging is not part of `v1.0.0`.

Do not hardcode SSH destinations, hosting providers, or secrets.

---

## 41. Deployment Convention

Document a minimal neutral deployment convention as future guidance.

Deployment automation is not part of `v1.0.0`.

Requirements:

- build assets in CI
- separate environment variables
- exclude development-only artifacts
- document how a future deployable artifact should be generated
- support future SSH/SFTP/pipeline extension
- no hosting vendor lock-in

---

## 42. Documentation

Keep documentation very short and actionable.

Required:

```text
README.md
AGENTS.md
CHANGELOG.md
docs/SETUP.md
docs/ARCHITECTURE.md
```

Avoid additional docs unless needed.

Each required document should explain only the decisions and commands needed to work safely with the starter. Prefer links between docs over repeating the same guidance.

---

## 43. `AGENTS.md`

This file is mandatory.

It must explain:

### Architecture rules

```text
Theme = presentation
site-content = content/domain configuration
.env = secrets/environment
project config = non-sensitive project behavior
```

### Block rules

- every block uses the modular folder convention
- no ACF registration in Blade
- no business logic in Blade
- use design tokens
- accessible by default

### Content rules

- CPTs belong in `site-content`
- taxonomies belong in `site-content`
- site settings use Settings API
- no project-specific model inside starter theme core

### Security rules

- never commit secrets
- sanitize input
- escape output
- use nonces/capabilities

### Harness rules

- inspect existing patterns before creating new ones
- prefer extending conventions over inventing new structures
- do not add dependencies unless required
- update documentation only when architecture/conventions change
- keep tasks small and independently verifiable

---

## 44. Semantic Versioning

Use:

```text
MAJOR.MINOR.PATCH
```

Examples:

```text
1.0.0 initial usable starter
1.1.0 backward-compatible starter feature
1.1.1 starter bug fix
2.0.0 breaking architectural change
```

Maintain:

```text
CHANGELOG.md
```

The starter version must be recorded in generated projects, for example:

```text
STARTER_VERSION=1.0.0
```

This is informational only.

There is no automatic upgrade mechanism.

---

## 45. Starter Lifecycle

The starter is a project generator/template.

```text
starter v1.0
   ↓
create Project A
   ↓
Project A evolves independently

starter v1.1
   ↓
create Project B
   ↓
Project B evolves independently
```

Do not implement automatic synchronization between starter and generated projects.

---

# Implementation Phases

## Phase 0 — Foundation Decisions

### Tasks

- [ ] Create repository.
- [ ] Add Bedrock.
- [ ] Add Sage.
- [ ] Pin supported runtime versions.
- [ ] Create root folder structure.
- [ ] Add `.env.example`.
- [ ] Add starter version.
- [ ] Create minimal README.
- [ ] Create initial AGENTS.md.

### Acceptance Criteria

- Repository installs successfully.
- WordPress boots locally.
- Sage builds successfully.
- Environment configuration is not hardcoded.
- Secrets are excluded from Git.

---

## Phase 1 — Theme and Design System

### Tasks

- [ ] Configure Tailwind.
- [ ] Create default design tokens.
- [ ] Create project token override layer.
- [ ] Define typography base.
- [ ] Define container/layout primitives.
- [ ] Define buttons.
- [ ] Define basic form styles.
- [ ] Create minimal `default`, `full-width`, and `landing` layouts.

### Acceptance Criteria

- Branding can be replaced without editing block markup.
- Components can consume shared tokens.
- No project-specific brand is hardcoded.

---

## Phase 2 — `site-content` Plugin

Scope for `v1.0.0`: minimal plugin foundation only.

### Tasks

- [ ] Create plugin bootstrap.
- [ ] Create modular folder structure.
- [ ] Add project feature configuration.
- [ ] Add example CPT disabled by default.
- [ ] Add example taxonomy disabled by default.
- [ ] Add Settings API admin page.
- [ ] Add global site settings.
- [ ] Add hook/filter extension pattern.

### Acceptance Criteria

- Plugin activates independently of theme internals.
- Example CPT/taxonomy can be toggled via flags.
- Global settings persist and are sanitized.
- Theme can consume global settings through a documented interface.

---

## Phase 3 — Gutenberg Block Infrastructure

### Tasks

- [ ] Define block folder contract.
- [ ] Create shared registration mechanism if needed.
- [ ] Create one reference block end-to-end.
- [ ] Implement repeated/nested content with native Gutenberg `InnerBlocks`.
- [ ] Validate ACF Free compatibility.
- [ ] Document block creation convention.
- [ ] Ensure block assets can load conditionally where practical.

### Acceptance Criteria

- A new block can be created by copying the reference pattern.
- Field registration, data preparation, and markup are separated.
- Block can be inserted and edited in Gutenberg.
- Repeated block content works without ACF Pro.
- No ACF Pro requirement exists.

---

## Phase 4 — `v1.0.0` Base Components

Implement:

- [ ] Hero
- [ ] Text + Image
- [ ] CTA
- [ ] Accordion / FAQ

### Acceptance Criteria

For every component:

- renders in frontend
- editable from Gutenberg
- fields use ACF Free for simple fields and native Gutenberg for block attributes, repeated content, and nested content
- accessible markup
- responsive
- consumes design tokens
- no business logic in Blade
- modular folder convention respected

---

## Phase 5 — Global Theme Features

Scope for `v1.0.0`: complete the minimum WordPress theme surface.

### Tasks

- [ ] Register primary navigation.
- [ ] Register footer navigation.
- [ ] Create accessible mobile navigation.
- [ ] Create site header.
- [ ] Create site footer.
- [ ] Create media helper/component.
- [ ] Configure image sizes.
- [ ] Create 404 template.
- [ ] Create search template.
- [ ] Create archive template.
- [ ] Create single template.
- [ ] Create index/blog template.

### Acceptance Criteria

- Base site is navigable.
- Menus work on desktop/mobile.
- Core templates render valid content.
- System templates are minimal and replaceable.
- Image markup uses responsive WordPress capabilities.

---

## Phase 6 — Cross-Cutting Baseline

### Tasks

- [ ] Add accessibility checklist.
- [ ] Add performance conventions.
- [ ] Add SEO compatibility conventions.
- [ ] Add analytics/marketing hooks.
- [ ] Add form integration convention.
- [ ] Make theme/plugin strings translatable.
- [ ] Add native logging/error environment rules.
- [ ] Add cache convention documentation.
- [ ] Add native security baseline.

### Acceptance Criteria

- No third-party plugin is required for these baselines.
- Production does not expose debug information.
- Theme strings are translatable.
- Analytics can be integrated without editing core templates extensively.

---

## Phase 7 — Bootstrap Automation

Scope for `v1.0.0`: create a working local project with minimum manual setup.

### Tasks

- [ ] Create `new-project.ps1`.
- [ ] Validate PHP/Composer/Node/WP-CLI.
- [ ] Automate project naming.
- [ ] Generate local `.env`.
- [ ] Document required LocalWP `.env` values.
- [ ] Install dependencies.
- [ ] Configure WordPress.
- [ ] Activate theme/plugin.
- [ ] Configure base options.
- [ ] Run frontend build.
- [ ] Print completion summary.

### Acceptance Criteria

A developer or agent can create a working project from the starter with minimal manual steps.

---

## Phase 8 — Docker (`v1.1+` conditional backlog)

Do not schedule this phase unless a concrete project need makes Docker necessary.

### Tasks

- [ ] Add Docker Compose configuration.
- [ ] Add DB service.
- [ ] Add app/runtime service.
- [ ] Document Docker bootstrap.
- [ ] Ensure non-Docker workflow still works.

### Future Acceptance Criteria

If this backlog item is activated, both workflows must be supported:

```text
native/local setup
```

and:

```text
docker compose up -d
```

---

## Phase 9 — Demo and Seed

### Tasks

- [ ] Create component showcase page.
- [ ] Create sample content for all `v1.0.0` blocks.
- [ ] Create primary/footer demo menus.
- [ ] Seed global settings.
- [ ] Verify showcase page renders header, navigation, footer, and all `v1.0.0` blocks.
- [ ] Gate demo functionality by environment/flag.

### Acceptance Criteria

A new starter instance can render the header, navigation, footer, and all `v1.0.0` components immediately in local/staging.

Production does not expose demo content automatically.

---

## Phase 10 — Quality and CI

Scope for `v1.0.0`: validation CI only.

### Tasks

- [ ] Configure minimal PHPCS.
- [ ] Configure ESLint.
- [ ] Configure Prettier.
- [ ] Add bootstrap smoke validation.
- [ ] Add GitHub Actions template.
- [ ] Build assets in CI.

### Acceptance Criteria

CI validates the starter without requiring project-specific infrastructure, artifact packaging, or deployment credentials.

---

## Phase 11 — Documentation and Release

Scope for `v1.0.0`: complete short operational docs only.

### Tasks

- [ ] Finalize README.
- [ ] Finalize AGENTS.md.
- [ ] Add SETUP.md.
- [ ] Add ARCHITECTURE.md.
- [ ] Add CHANGELOG.md.
- [ ] Document how to create a block briefly.
- [ ] Document project config briefly.
- [ ] Tag `v1.0.0`.

### Acceptance Criteria

A developer or harness can understand:

- how to bootstrap
- where code belongs
- how to add a block
- how to change the design system
- how to enable features
- where secrets belong
- how to run validation

without needing undocumented knowledge.

Required docs stay concise; do not turn `v1.0.0` documentation into a full manual.

---

# Harness Execution Rules

The harness should execute tasks incrementally.

For each task:

1. inspect existing structure
2. identify files to modify/create
3. implement the smallest complete change
4. run relevant validation
5. fix failures
6. avoid unrelated refactors
7. preserve starter conventions
8. update documentation only if the contract changes

Do not execute future phases when the current phase acceptance criteria fail.

---

# Definition of Done

The starter is ready for `v1.0.0` when all of the following are true:

- [ ] Bedrock boots correctly.
- [ ] Sage builds correctly.
- [ ] Tailwind design system works.
- [ ] Project tokens can replace starter branding.
- [ ] ACF Free is the only required content-field plugin.
- [ ] `site-content` is active and modular.
- [ ] Feature flags work.
- [ ] Global Settings API works.
- [ ] 4 `v1.0.0` Gutenberg components work.
- [ ] Components follow the modular convention.
- [ ] Components are responsive.
- [ ] Components meet the accessibility baseline.
- [ ] Navigation works.
- [ ] System templates exist.
- [ ] Media handling is responsive.
- [ ] WordPress-native localization basics exist.
- [ ] Security baseline is active.
- [ ] Local/staging/production configuration is separated.
- [ ] Secrets are not version controlled.
- [ ] WP-CLI bootstrap works.
- [ ] Demo page and seed are optional.
- [ ] Minimal linting works.
- [ ] Bootstrap smoke validation works.
- [ ] Minimal CI works.
- [ ] AGENTS.md is complete.
- [ ] README.md is sufficient to bootstrap.
- [ ] CHANGELOG.md exists.
- [ ] Repository is tagged `v1.0.0`.

---

# Explicit Non-Goals

Do not implement by default:

- ACF Pro
- page builders
- Elementor
- WPBakery
- automatic starter upgrades
- Redis
- Varnish
- caching plugins
- security plugins
- SEO plugins
- analytics providers
- cookie providers
- forms plugins
- multilingual plugins
- WP-Cron job architecture
- form submission storage
- generic external API framework
- project-specific CPTs
- project-specific taxonomies
- project-specific business logic
- hosting-provider-specific deployment
- mandatory Docker
- heavy automated test suites

---

# First Harness Milestone

The first execution milestone should implement only:

```text
Phase 0 — Foundation Decisions
Phase 1 — Theme and Design System
```

Stop after validating:

```bash
composer install
npm install
npm run build
```

and confirming WordPress + Sage boot correctly.

Do not start Gutenberg components until the foundation and design-system override mechanism are stable.
