MoneyColumn [![build status](https://secure.travis-ci.org/chargify/money_column.png)](http://travis-ci.org/chargify/money_column)
===========

A set of helper methods for working with money-based attributes.

## How it works

Let's say you have the following Car class:

``` ruby
class Car
  include MoneyColumn::StoresMoney

  attr_accessor :price_in_cents

  stores_money :price

  def currency
    "USD"
  end
end

So let's go ahead and store a price_in_cents for the car:

``` ruby
car = Car.new
car.price_in_cents = 5000
```

Since we want to show this in a view as `$ 50.00`, we can now do the following:

``` ruby
> car.price.format
=> "$50.00"

> car.price
 => #<Money:0x1016e9fb8 @cents=5000, @bank=#<Money::VariableExchangeBank:0x10143f6f0 @mutex=#<Mutex:0x10143f678>, @rates={}>, @currency="USD">
```

If the `currency` instance method is defined on your class, MoneyColumn will use that. Otherwise, it will use the default currency specified in the Money gem.

## Under the covers

When you define `stores_money :price`, MoneyColumn looks for an attribute named `price_in_cents` to use for its conversion.

If you want to explicity tell MoneyColumn where to look for the cents_attribute, do the following:

``` ruby
class CarWithSpecifiedAttribute
  include MoneyColumn::StoresMoney
  
  attr_accessor :amount_in_cents
  
  stores_money :price, :cents_attribute => "amount_in_cents"
end
```
