# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cheque/version'

Gem::Specification.new do |spec|
  spec.name = 'cheque'
  spec.version = Cheque::VERSION
  spec.authors = ['Fernando Almeida']
  spec.email = ['fernando@fernandoalmeida.net']

  spec.summary = 'A gem to generate cheque copy and cheque printing'
  spec.description = 'Cheque copy and printing'
  spec.homepage = 'https://github.com/fernandoalmeida/cheque'
  spec.license = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(/^(test|spec|features)\//)
  end
  spec.executables = spec.files.grep(/^exe\//) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'prawn', '~> 2.0'

  spec.add_development_dependency 'bundler', '>= 1.7.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'pry', '~> 0.10'
  spec.add_development_dependency 'rspec', '~> 3.2'
  spec.add_development_dependency 'pdf-inspector', '~> 1.2'
end
