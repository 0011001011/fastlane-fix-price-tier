# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'credentials_manager/version'

Gem::Specification.new do |spec|
  spec.name          = "credentials_manager"
  spec.version       = CredentialsManager::VERSION
  spec.authors       = ["Felix Krause"]
  spec.email         = ["fastlane@krausefx.com"]
  spec.summary       = %q{Password manager used in Fastlane.tools}
  spec.description   = %q{Password manager used in Fastlane.tools}
  spec.homepage      = "http://fastlane.tools"
  spec.license       = "MIT"

  spec.required_ruby_version = '>= 2.0.0'

  spec.files = Dir["lib/**/*"] + %w{ README.md LICENSE }

  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'highline', '~> 1.6.21' # user inputs (e.g. passwords)
  spec.add_dependency 'colored' # coloured terminal output
  spec.add_dependency 'security', '~> 0.1.3' # Mac OS Keychain manager

  # Development only
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 3.1.0'
end
