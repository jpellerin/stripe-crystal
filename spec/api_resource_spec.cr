require "./spec_helper"

describe Stripe do
  describe "APIResource" do
    describe "Customer" do
      it "should not do a network fetch when creating a new resource" do
        Stripe::Customer.new("someid")
      end

      it "should not do a network fetch when constructing from hash" do
        Stripe::Customer.construct_from({
          "id": "somecustomer",
          "card": {"id": "somecard", "object": "card"},
          "object": "customer"
        })
      end

      it "should not make a request when setting an attribute" do
        c = Stripe::Customer.new("test_customer");
        c["card"] = {"id": "somecard", "object": "card"}
      end

      it "should not make a request when accessing id" do
        c = Stripe::Customer.new("test_customer")
        c.id
      end

      it "should raise an exception for a nil api key" do
        expect_raises ArgumentError do
          Stripe::Customer.all({} of String => String, nil)
        end
        expect_raises ArgumentError do
          Stripe::Customer.all({} of String => String, { "api_key": nil })
        end
      end
      
    end
  end
end