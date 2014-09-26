# Author:: MinixLi (gmail: MinixLi1986)
# Homepage:: http://citrus.inspawn.com
# Date:: 8 July 2014

$:.push File.expand_path('../lib', __FILE__)

require 'citrus-monitor/version'

Gem::Specification.new do |spec|
  spec.name        = 'pomelo-citrus-monitor'
  spec.version     = CitrusMonitor::VERSION
  spec.platform    = Gem::Platform::RUBY
  spec.authors     = ['MinixLi']
  spec.email       = 'MinixLi1986@gmail.com'
  spec.description = %q{pomelo-citrus-monitor is a simple clone of pomelo-monitor, it provides a simple, comprehensive monitoring tool for operating-system and process}
  spec.summary     = %q{pomelo-monitor clone written in Ruby using EventMachine}
  spec.homepage    = 'https://github.com/minixli/pomelo-citrus-monitor'
  spec.license     = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency('eventmachine', '~> 0')
  spec.add_dependency('os', '~> 0')
end
