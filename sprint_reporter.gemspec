# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sprint_reporter/version'

Gem::Specification.new do |spec|
  spec.name          = 'sprint_reporter'
  spec.version       = SprintReporter::VERSION
  spec.authors       = ['Rico Sta. Cruz']
  spec.email         = ['rstacruz@users.noreply.github.com']

  spec.summary       = %q{sprint_reporter}
  spec.description   = %q{sprint_reporter}
  spec.homepage      = 'https://github.com/rstacruz/sprint_reporter'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
end
