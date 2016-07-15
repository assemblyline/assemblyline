# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "assemblyline/version"

Gem::Specification.new do |spec|
  spec.name          = "assemblyline"
  spec.version       = Assemblyline::VERSION
  spec.authors       = ["Ed Robinson"]
  spec.email         = ["ed@reevoo.com"]

  spec.summary       = " Build and Test and Ship your Apps in Containers "
  spec.description   = " Build and Test and Ship your Apps in Containers "
  spec.homepage      = "http://www.a10e.org"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    fail "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(/^(test|spec|features)\//) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(/^exe\//) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "toml-rb", "~> 0.3"
  spec.add_dependency "bundler", "~> 1.12"

  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "reevoocop"
  spec.add_development_dependency "simplecov", "~> 0.11"
  spec.add_development_dependency "guard-rspec", "~> 4.7"
end
