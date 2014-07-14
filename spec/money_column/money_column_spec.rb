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
    it "returns a money object based on the inferred cents_attribute" do
      car = Car.new
      car.price_in_cents = 1000
      expect(car.price).to eql(10.to_money)
    end

    it "returns a money object based on the stated cents_attribute" do
      car = CarWithSpecifiedAttribute.new
      car.amount_in_cents = 5000
      expect(car.price).to eql(50.to_money)
    end
  end

  describe "setter method" do
    it "passes on money values" do
      car = Car.new
      car.price = 1.to_money
      expect(car.price).to eql(1.to_money)
    end

    it "converts string values to money objects" do
      car = CarWithCurrency.new
      car.price = '2'
      expect(car.price).to eql(2.to_money)
    end

    it "converts to money objects in the correct currency automatically" do
      car = CarWithNonDefaultCurrency.new
      car.price = '4'
      expect(car.price).to eql(Money.new(400, 'GBP'))
    end

    it "converts numeric values to money objects" do
      car = Car.new
      car.price = 3
      expect(car.price).to eql(3.to_money)
    end

    describe "when nil is allowed" do
      it "treats blank values as nil" do
        car = Car.new
        car.price = ''
        expect(car.price).to be_nil
      end
    end

    describe "when nil isn't allowed" do
      it "treats blank values as $0" do
        car = CarNilNotAllowed.new
        car.price = ''
        expect(car.price).to eql(Money.new(0, 'USD'))
      end
    end

    it "allows existing prices to be set to nil with a blank value" do
      car = Car.new
      car.price = 500.to_money
      expect(car.price).to_not be_nil
      car.price = ''
      expect(car.price).to be_nil
    end
  end

  describe "declaring a money field" do
    it "allows the field to be declared with a different cents field" do
      car = CarWithSpecifiedAttribute.new
      car.price = 5.to_money

      expect(car.price).to eql(5.to_money)
      expect(car.amount_in_cents).to eql(5.to_money.cents)
    end
  end

end
