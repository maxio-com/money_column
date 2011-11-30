Gem::Specification.new do |s|
  s.specification_version = 3 if s.respond_to? :specification_version=
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.rubygems_version = '1.3.7'
  
  s.name    = 'money_column'
  s.version = '0.1.0'
  s.date    = '2011-11-30'
  s.summary = 'A set of helper methods for working with money-based database columns.'
  s.description = 'A set of helper methods for working with money-based database columns.'
  s.authors = ["Michael Klett"]
  s.email = 'support@chargify.com'
  s.homepage = 'http://github.com/chargify/money_column'
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = %w[lib]

  # Runtime Dependencies
  s.add_runtime_dependency('activerecord', '>= 2.3.14')
  s.add_runtime_dependency('money', '~> 2.2.0')

  # Development Dependencies
  s.add_development_dependency('sqlite3', '~> 1.3.4')
  s.add_development_dependency('rake', '~> 0.9.2')
  s.add_development_dependency('rspec', '~> 2.7.0')
  s.add_development_dependency('guard-rspec', '~> 0.5.0')
  s.add_development_dependency('growl', '~> 1.0.3')
  s.add_development_dependency('rb-fsevent', '~> 0.4.2')
end
