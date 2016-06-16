[![Gem Version](https://badge.fury.io/rb/renuo-upload.svg)](https://badge.fury.io/rb/renuo-upload) [![Build Status](https://travis-ci.org/renuo/renuo-upload-ruby.svg?branch=master)](https://travis-ci.org/renuo/renuo-upload-ruby) [![Build Status](https://travis-ci.org/renuo/renuo-upload-ruby.svg?branch=develop)](https://travis-ci.org/renuo/renuo-upload-ruby)

# Renuo Upload

Gem for Ruby 2.0+ applications that use the excellent Renuo Upload

## Installation

Add this line to your application's Gemfile and run bundle:

```ruby
gem 'renuo-upload'
```

## Usage

### Configuration

The configuration is optional. If you want to use it, add an initializer:

```ruby
RenuoUpload.configure do |config|
  config.api_key = 'custom-api-key'             # Default: ENV['RENUO_UPLOAD_API_KEY']
  config.signing_url = 'custom-signing-url'     # Default: ENV['RENUO_UPLOAD_SIGNING_URL']
end
```

### Example

```ruby
require 'renuo-upload'

file = File.new('tmp/examplefile.pdf')
file_url = RenuoUpload.upload!(file)
```

## Development

### Contributing

See the [CONTRIBUTING](CONTRIBUTING.md) file.

### Release

```sh
git flow release start [.....]
# adjust version.rb
# check (and adjust) CHANGELOG.md
bundle install
git commit -av
git flow release finish [.....]
git push origin develop:develop
git push origin master:master
git checkout master
bundle exec rake release
git checkout develop
```

## Copyright

Renuo GmbH (https://www.renuo.ch) - [MIT LICENSE](LICENSE) - 2016
