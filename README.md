# nation_builder

[![CI](https://github.com/controlshift/nation_builder/actions/workflows/ci.yml/badge.svg)](https://github.com/controlshift/nation_builder/actions/workflows/ci.yml)

A small Ruby client for the [NationBuilder v1 API](https://nationbuilder.com/api_documentation) people and tags
endpoints, built on Faraday.

## Usage

The client takes an OAuth 2.0 access token. Obtaining one (the authorisation code flow) is left to your application.

```ruby
require 'nation_builder'

client = NationBuilder.new(hostname: 'mynation.nationbuilder.com', token: access_token)

client.people.match('email' => 'george@example.com') # person hash, or nil when there is no match
client.people.add('person' => { 'email' => 'george@example.com', 'first_name' => 'George' })
client.people.update(17, 'person' => { 'email_opt_in' => false })
client.people.add_tagging(17, 'volunteer')
client.tags.list
```

Optional keyword arguments: `logger:` (logs rate limit headers), `instrumentation:` (a callable invoked before each
request with `{ path:, request_type: }`), `adapter:`, `open_timeout:` and `timeout:`.

### Errors

Non-2xx responses raise `NationBuilder::Error`, which exposes `status`, `code` (NationBuilder's error code) and
`body`. Subclasses: `NotFoundError`, `ValidationError` (`#errors`) and `RateLimitedError` (`#limit`, `#remaining`,
`#reset_at`).

## Development

```
bundle install
bundle exec rake   # rubocop + rspec
```

## Release

Bump `NationBuilder::VERSION` in `lib/nation_builder/version.rb`, update `CHANGELOG.md`, merge, then
`bundle exec rake release`.

## Copyright

Copyright (c) 2013 ControlShift Ltd. See LICENSE.txt for further details.
