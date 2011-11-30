$:.unshift File.expand_path('../lib', File.dirname(__FILE__))

require 'rspec'
require 'money_column'

RSpec.configure do |config|
  config.filter_run :focused => true
  config.run_all_when_everything_filtered = true
  config.alias_example_to :fit, :focused => true
  config.color_enabled = true
end

ActiveRecord::Base.configurations = {'sqlite3' => {:adapter => 'sqlite3', :database => ':memory:'}}
ActiveRecord::Base.establish_connection('sqlite3')

ActiveRecord::Base.logger = Logger.new(STDERR)
ActiveRecord::Base.logger.level = Logger::WARN

# Load test database schema
load File.dirname(__FILE__) + "/schema.rb"
