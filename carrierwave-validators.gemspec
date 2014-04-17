# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'carrierwave/validators/version'

Gem::Specification.new do |spec|
  spec.name          = "carrierwave-validators"
  spec.version       = CarrierWave::Validators::VERSION
  spec.authors       = ["Kirti Thorat"]
  spec.email         = ["kirti.brenz@gmail.com"]
  spec.summary       = %q{CarrierWave extension for validating uploaded files.}
  spec.description   = %q{CarrierWave extension to validate files uploaded using carrierwave.}
  spec.homepage      = "https://github.com/kirtithorat/carrierwave-validators"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", ">= 3.2.0"
  spec.add_dependency "carrierwave", [">= 0.8.0", "< 0.11.0"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake", "~> 10.2.2"
  spec.add_development_dependency "sqlite3", "~> 1.3.9"
  spec.add_development_dependency "rspec", "~> 2.14.1"
  spec.add_development_dependency "database_cleaner", "~> 1.2.0"
end
