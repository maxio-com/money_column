MoneyColumn
===========

A set of helper methods for working with money-based database columns.


## How it works

The money values are stored in the database in cents.  The currency is not (necessarily) stored in the same table - instead, the currency is defined by a +currency+ method on the object instance.

Reading a money column returns a Money object (or nil, if :allow_nil is true), in the currency defined by the object instance.

Writing a money column assigns the cents-based database-backed attribute, and is assumed to be in the
currency of the target instance.

## Example

``` ruby
class Subscription < ActiveRecord::Base
  belongs_to :site
  
  stores_money :balance
  
  def currency
    site.currency
  end
end
```

In this example, +balance+ provides a Money-based interface to the underlying +balance_in_cents+ database column.  The currency is delegated to the site.
