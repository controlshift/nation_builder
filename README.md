# nation_builder

A very simple ruby gem for interacting with NB people API. 

http://nationbuilder.com/api_documentation

### Usage

```
require 'nation_builder'
client = NationBuilder.new(hostname: 'whatever.nationbuilder.com', client_id: 'id', client_secret: 'secret', username: 'you@nation.com', password: 'pass')
client.people.create('person' => {'first_name' => 'George', 'last_name' => 'Washington', 'email' => 'george@washington.com'})
client.people.match('email' => 'george@washington.com) # either a person hash or nil. 
client.people.list # returns people in nation
client.tags.list # all tags.
```

### Contributing 

The current gem is minimalist -- but we'd welcome pull requests with additional functionality!

[![CI Status](https://github.com/controlshift/nation_builder/actions/workflows/ci.yml/badge.svg)](https://github.com/controlshift/nation_builder/actions/workflows/ci.yml)

### Release

```
rake version:bump:minor
BRANCH=main rake release
```

### Copyright

Copyright (c) 2013 ControlShift Ltd. See LICENSE.txt for
further details.

