[![Build Status](https://travis-ci.org/renuo/renuo-upload-ruby.svg?branch=master)](https://travis-ci.org/renuo/renuo-upload-ruby) [![Build Status](https://travis-ci.org/renuo/renuo-upload-ruby.svg?branch=develop)](https://travis-ci.org/renuo/renuo-upload-ruby)

# Renuo Upload

## Installation

Add this line to your application's Gemfile and run bundle:

```ruby
gem 'renuo-cms-rails'
```

## Example Usage

```ruby
require 'renuo-upload'

file = File.new('tmp/examplefile.pdf')
file_url = RenuoUpload.upload!(file)
```
