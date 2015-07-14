require "./spec_helper"

describe Stripe::Customer do

  describe "properties" do
    it "exist" do
      c = Stripe::Customer.new
      c.responds_to?(:id).should be_true
      c.responds_to?(:created).should be_true
      c.responds_to?(:livemode).should be_true
    end
  end

  describe "the all() method" do
    it "exists" do
      Stripe::Customer.responds_to?(:all).should be_true
    end

    it "makes an api call" do
      WebMock.wrap do
        customers = Stripe::Customer.all(limit=3)
        customers.should_not be_nil
      end
    end
  end
end
