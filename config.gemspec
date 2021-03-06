# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'config/version'

Gem::Specification.new do |spec|
  spec.name          = 'config'
  spec.version       = Config::VERSION
  spec.authors       = ['Juan D Frias']
  spec.email         = ['juandfrias@gmail.com']

  spec.summary       = 'Global configuration'
  spec.homepage      = 'https://github.com/hawkprime/ruby-config'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
end
