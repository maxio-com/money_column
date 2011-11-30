require 'spec_helper'

describe "MoneyColumn" do
  describe "setter method" do
    it "should pass on money values" do
      MoneyExample.new(:amount => 1.to_money).amount.should == 1.to_money
    end
    
    it "should convert string values to money objects" do
      MoneyExample.new(:amount => '2').amount.should == 2.to_money
    end
    
    it "should convert to money objects in the correct currency automatically" do
      MoneyExampleWithNonDefaultCurrency.new(:amount => '4').amount.should == Money.new(400, 'GBP')
    end

    it "should convert numeric values to money objects" do
      MoneyExample.new(:amount => 3).amount.should == 3.to_money
    end

    describe "when nil is allowed" do
      it "should treat blank values as nil" do
        MoneyExample.new(:amount => '').amount.should be_nil
      end
    end
    
    describe "when nil isn't allowed" do
      it "should treat blank values as $0" do
        MoneyExampleThatDoesNotAllowNil.new(:amount => '').amount.should == Money.new(0, 'USD')
      end
    end

    it "should allow existing amounts to be set to nil with a blank value" do
      me = MoneyExample.new(:amount => 500.to_money)
      me.update_attribute :amount, ''
      me.reload
      me.amount.should be_nil
    end
  end
  
  describe "declaring a money field" do
    it "should allow the field to be declared with a different cents field" do
      me = MoneyExampleWithSpecifiedColumnName.create!(:amt => 5.to_money)
      me.amt.should == 5.to_money
      me.reload.amt.should == 5.to_money
      me.amount_in_cents.should == 5.to_money.cents
    end
  end
  
end
