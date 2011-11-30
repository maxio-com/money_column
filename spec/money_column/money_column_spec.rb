require 'spec_helper'

class Car
  include MoneyColumn::StoresMoney
  attr_accessor :price_in_cents
  stores_money :price
end

class CarWithCurrency
  include MoneyColumn::StoresMoney
  attr_accessor :price_in_cents
  stores_money :price

  def currency
    ::Money.default_currency
  end
end

class CarWithNonDefaultCurrency
  include MoneyColumn::StoresMoney
  attr_accessor :price_in_cents
  stores_money :price

  def currency
    "GBP"
  end
end

class CarNilNotAllowed
  include MoneyColumn::StoresMoney
  attr_accessor :price_in_cents
  stores_money :price, :allow_nil => false
end

class CarWithSpecifiedAttribute
  include MoneyColumn::StoresMoney
  attr_accessor :amount_in_cents
  stores_money :price, :cents_attribute => "amount_in_cents"
end

describe "MoneyColumn" do
  describe "getter method" do
    it "should return a money object based on the inferred cents_attribute" do
      car = Car.new
      car.price_in_cents = 1000
      car.price.should == 10.to_money
    end

    it "should return a money object based on the stated cents_attribute" do
      car = CarWithSpecifiedAttribute.new
      car.amount_in_cents = 5000
      car.price.should == 50.to_money
    end
  end
  
  describe "setter method" do
    it "should pass on money values" do
      car = Car.new
      car.price = 1.to_money
      car.price.should == 1.to_money
    end
    
    it "should convert string values to money objects" do
      car = CarWithCurrency.new
      car.price = '2'
      car.price.should == 2.to_money
    end
    
    it "should convert to money objects in the correct currency automatically" do
      car = CarWithNonDefaultCurrency.new
      car.price = '4'
      car.price.should == Money.new(400, 'GBP')
    end

    it "should convert numeric values to money objects" do
      car = Car.new
      car.price = 3
      car.price.should == 3.to_money
    end

    describe "when nil is allowed" do
      it "should treat blank values as nil" do
        car = Car.new
        car.price = ''
        car.price.should be_nil
      end
    end
    
    describe "when nil isn't allowed" do
      it "should treat blank values as $0" do
        car = CarNilNotAllowed.new
        car.price = ''
        car.price.should == Money.new(0, 'USD')
      end
    end

    it "should allow existing prices to be set to nil with a blank value" do
      car = Car.new
      car.price = 500.to_money
      car.price.should_not be_nil
      car.price = ''
      car.price.should be_nil
    end
  end
  
  describe "declaring a money field" do
    it "should allow the field to be declared with a different cents field" do
      car = CarWithSpecifiedAttribute.new
      car.price = 5.to_money
      car.price.should == 5.to_money
      car.amount_in_cents.should == 5.to_money.cents
    end
  end
  
end
