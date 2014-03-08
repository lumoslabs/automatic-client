# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'automatic/client/version'

Gem::Specification.new do |spec|
  spec.name          = "automatic-client"
  spec.version       = Automatic::Client::VERSION
  spec.authors       = ["Nate Klaiber"]
  spec.email         = ["nate@theklaibers.com"]
  spec.description   = %q{ Interact with the Automatic API. }
  spec.summary       = %q{ Interact with all aspects of the Automatic API, including trips, vehicles, and events. }
  spec.homepage      = "https://github.com/nateklaiber/automatic-client"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency("bundler", "~> 1.3")
  spec.add_development_dependency("rake")
  spec.add_development_dependency("rspec")
  spec.add_development_dependency("yard")
  spec.add_development_dependency("webmock")

  spec.add_dependency("thor")
  spec.add_dependency("faraday")
  spec.add_dependency("faraday_middleware")
  spec.add_dependency("multi_json")
  spec.add_dependency("terminal-table")
  spec.add_dependency("tzinfo")
  spec.add_dependency("dotenv")
  spec.add_dependency("addressable")
end
