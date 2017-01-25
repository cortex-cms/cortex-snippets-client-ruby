# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cortex/snippets/client/version'

Gem::Specification.new do |spec|
  spec.name          = 'cortex-snippets-client'
  spec.version       = Cortex::Snippets::Client::VERSION
  spec.authors       = ['CareerBuilder Employer Site & Content Products']
  spec.email         = ['EmployerSiteContentProducts@cb.com']
  spec.license       = 'Apache-2.0'

  spec.summary       = %q{Provides loading of Cortex snippets for Ruby applications, with some Rails ViewHelpers}
  spec.homepage      = 'https://github.com/cortex-cms/cortex-snippets-client-ruby'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'cortex-client', '~> 0.10'
  spec.add_dependency 'addressable', '~> 2.5'

  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'rspec', '~> 3.5'
end
