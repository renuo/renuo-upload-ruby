lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'renuo_upload/version'

Gem::Specification.new do |spec|
  spec.name = 'renuo-upload'
  spec.version = RenuoUpload::VERSION
  spec.authors = ['Cyril Kyburz', 'Alessandro Rodi']
  spec.email = ['cyril.kyburz@renuo.ch', 'alessandro.rodi@renuo.ch']

  spec.summary = 'Ruby client for renuo upload'
  spec.description = 'The renuo upload allows in compination with the renuo upload service to easily upload files.'
  spec.homepage = 'https://github.com/renuo/renuo-upload-ruby'
  spec.license = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features|bin)/}) }
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")

  spec.add_dependency 'rest-client', '>= 1.8.0'

  spec.add_development_dependency 'rspec', '>= 3.4.0'
  spec.add_development_dependency 'rubocop', '>= 0.40.0'
  spec.add_development_dependency 'reek', '>= 4.0.4'
  spec.add_development_dependency 'climate_control', '>= 0.0.3'
  spec.add_development_dependency 'pry', '>= 0.10.3'
end
