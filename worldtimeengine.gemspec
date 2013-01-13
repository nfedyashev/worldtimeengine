# encoding: utf-8

Gem::Specification.new do |gem|
  gem.add_dependency 'hashie'
  gem.add_dependency 'httparty'
  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'webmock'
  gem.authors = ["Nikita Fedyashev"]
  gem.description = %q{A Ruby wrapper for the WorldTimeEngine.com API.}
  gem.email = ['nfedyashev@gmail.com']
  gem.files = %w(LICENSE.md README.md Rakefile worldtimeengine.gemspec)
  gem.files += Dir.glob("lib/**/*.rb")
  gem.files += Dir.glob("spec/**/*")
  gem.homepage = 'https://github.com/nfedyashev/worldtimeengine'
  gem.name = 'worldtimeengine'
  gem.require_paths = ['lib']
  gem.required_rubygems_version = Gem::Requirement.new('>= 1.3.6')
  gem.summary = %q{WorldTimeEngine API wrapper}
  gem.test_files = Dir.glob("spec/**/*")
  gem.version = '0.0.5'
end
