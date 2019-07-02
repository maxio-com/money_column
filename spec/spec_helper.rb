$:.unshift File.expand_path('../lib', File.dirname(__FILE__))

require 'bundler'
Bundler.require

RSpec.configure do |config|
  config.filter_run focused: true
  config.alias_example_to :fit, focused: true
  config.run_all_when_everything_filtered = true
end

I18n.config.available_locales = :en
