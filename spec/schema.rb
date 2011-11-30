ActiveRecord::Schema.define(:version => 0) do
  create_table :money_examples, :force => true do |t|
    t.integer :amount_in_cents
  end
end

class MoneyExample < ActiveRecord::Base
  stores_money :amount
end

class MoneyExampleWithCurrency < ActiveRecord::Base
  set_table_name "money_examples"

  stores_money :amount

  def currency
    ::Money.default_currency
  end
end

class MoneyExampleWithNonDefaultCurrency < ActiveRecord::Base
  set_table_name "money_examples"

  stores_money :amount

  def currency
    "GBP"
  end
end

class MoneyExampleWithSpecifiedColumnName < ActiveRecord::Base
  set_table_name "money_examples"
  
  stores_money :amt, :cents_column => "amount_in_cents"
end

class MoneyExampleThatDoesNotAllowNil < ActiveRecord::Base
  set_table_name "money_examples"

  stores_money :amount, :allow_nil => false
end
