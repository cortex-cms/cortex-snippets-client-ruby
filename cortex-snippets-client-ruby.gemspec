# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cortex/snippets/version'

Gem::Specification.new do |spec|
  spec.name          = 'cortex-snippets-client-ruby'
  spec.version       = Cortex::Snippets::VERSION
  spec.authors       = ['CB Content Enablement']
  spec.email         = ['ContentEnablementProductTeam@careerbuilder.com']
  spec.license       = 'Apache-2.0'

  spec.summary       = %q{Provides loading of Cortex snippets for Ruby applications, with some Rails ViewHelpers}
  spec.homepage      = 'https://github.com/cortex-cms/cortex-snippets-client-ruby'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'cortex-client', '~> 0.8.0'
  spec.add_dependency 'connection_pool', '~> 2.2.0'
  spec.add_dependency 'addressable', '~> 2.4.0'

  spec.add_development_dependency 'rake', '~> 11.1'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'pry'
end
