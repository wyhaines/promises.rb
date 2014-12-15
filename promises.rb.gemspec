# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'swiftcore/promises/version'

Gem::Specification.new do |spec|
  spec.name          = "promises.rb"
  spec.version       = Swiftcore::Promise::VERSION
  spec.authors       = ["Kirk Haines"]
  spec.email         = ["wyhaines@gmail.com"]
  spec.summary       = %q{A collection of classes that implement a flexible family of callbacks, futures, and promises.}
  spec.description   = %q{}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "test-unit", "~> 2.1.5.0"
end
