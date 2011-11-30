$:.unshift File.expand_path('../lib', File.dirname(__FILE__))

require 'money_column'
require 'rspec'

# Establish connection with in memory SQLite 3 database
# ActiveRecord::Base.send :establish_connection, :adapter => "sqlite3", :database => ":memory:"

# Establish connection with in memory SQLite 3 database
# ActiveRecord::Base.establish_connection :adapter => "sqlite3", :database => ":memory:"

# Load database schema
# load File.dirname(__FILE__) + "/schema.rb"

RSpec.configure do |config|
  config.filter_run :focused => true
  config.run_all_when_everything_filtered = true
  config.alias_example_to :fit, :focused => true
  config.color_enabled = true
end
