require 'rubygems'
require 'money'
require 'money_column/stores_money'
require 'monetize'

# FREEDOM PATCH - Since a money column might validly return nil, 
# let's allow +format+ to be called on nil and just return nil as a string
NilClass.class_eval do
  def format
    nil.to_s
  end
end
