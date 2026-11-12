# Changelog

## 1.0.0

Breaking:

- Requires Ruby 3.2 or later.
- Built on Faraday 2 instead of oauth2. The client authenticates with an access token only:
  `NationBuilder.new(hostname:, token:)`. `client_id`, `client_secret`, `username` and `password` are gone.
- Errors are `NationBuilder::Error` and its subclasses `NotFoundError`, `ValidationError` and `RateLimitedError`,
  instead of `OAuth2::Error`. `NationBuilder::Exceptions::ValidationError` is now `NationBuilder::ValidationError`.
- No longer depends on activesupport or pins json.
- `People#create_or_update` and `People#match_or_add` are removed; compose `match` with `add`/`update` instead.
- `People#delete_tagging` returns nil and raises on failure.
- `Tags#people` now calls `tags/:tag/people`, and tag names are escaped as path segments (`%20`, not `+`).
- Instrumentation also replaces trailing numeric IDs, e.g. `people/123` becomes `people/_`.

Other:

- Request timeouts default to 10s open / 30s read.
- Replaced juwelier with a plain gemspec and Bundler's gem tasks; CI runs RuboCop and RSpec on Ruby 3.2–4.0.
