# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'memonic/version'

Gem::Specification.new do |spec|
  spec.name          = "memonic"
  spec.version       = Memonic::VERSION
  spec.authors       = ["John Carney"]
  spec.email         = ["john@carney.id.au"]
  spec.summary       = %q{A simple, lightweight memoization helper.}
  spec.description   = %q{Memonic is a simple, lightweight memoization helper.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.1.0'

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "coveralls"
end
