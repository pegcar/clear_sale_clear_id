# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'clear_sale_clear_id/version'

Gem::Specification.new do |spec|
  spec.name          = 'clear_sale_clear_id'
  spec.version       = ClearSaleClearId::VERSION
  spec.authors       = ['Rafael da Silva Almeida']
  spec.email         = ['eusou@rafaelalmeida.net']

  spec.summary       = %q{Intergrate with ClearSale ClearID}
  spec.description   = %q{Intergrate with ClearSale ClearID}
  spec.homepage      = 'https://github.com/pegcar/clear_sale_clear_id'
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'equivalent-xml'
  spec.add_dependency 'builder'
  spec.add_dependency 'savon', '>= 2.6.0'
  spec.add_dependency 'nori', '>= 2.6.0'

  spec.add_development_dependency 'factory_girl'
  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'pry-nav'
  spec.add_development_dependency 'dotenv'
  spec.add_development_dependency 'webmock' , '~> 1.7.0'
  spec.add_development_dependency 'vcr' , '~> 1.11.3'
end
