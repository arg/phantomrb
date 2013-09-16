# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'phantomrb/version'

Gem::Specification.new do |spec|
  spec.name = 'phantomrb'
  spec.version = Phantomrb::VERSION
  spec.authors = ['Andrei Gladkyi']
  spec.email = ['arg@arglabs.net']
  spec.description = 'An interface with PhantomJS for Ruby.'
  spec.summary = 'An interface with PhantomJS for Ruby.'
  spec.homepage = 'https://github.com/agladkyi/phantomrb'
  spec.license = 'MIT'

  spec.files = `git ls-files`.split($/)
  spec.test_files = spec.files.grep(/^spec\//)
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '>= 2.0.0'
end
