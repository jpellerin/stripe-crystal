require "./spec_helper"

describe Stripe::Customer do

  describe "properties" do
    it "exists" do
      c = Stripe::Customer.new
      c.responds_to?(:id).should be_true
      c.responds_to?(:created).should be_true
      c.responds_to?(:livemode).should be_true
    end

    it "emits json including the values of set properties" do
      c = Stripe::Customer.new
      c.id = "hi"
      h = JSON.parse(c.to_json)
      h.should_not be_nil
      if h
        h_h = h as Hash(String,JSON::Type)
        h_h["id"].should eq("hi")
      end
    end

    it "can be instantiated from minimal json" do
      c = Stripe::Customer.from_json(%({"id":"1", "object":"o", "created":1, "livemode":false}))
      c.id.should eq("1")
      c.object.should eq("o")
      c.created.should eq(1)
      c.livemode.should eq(false)
    end

    it "can be instantiated from a string" do
      c = Stripe::Customer.new("cust_1")
      c.id.should eq("cust_1")
    end

    it "can be instantiated from sample data" do
      data = File.read("spec/sample_data/customer.json")
      c = Stripe::Customer.from_json(data)
      c.id.should eq("cus_6blhDTjCsoUECV")
    end
  end

  describe "the all() method" do
    it "exists" do
      Stripe::Customer.responds_to?(:all).should be_true
    end

    it "makes an api call" do
      WebMock.wrap do
        WebMock.stub(:get, "api.stripe.com/v1/customers?limit=3")
          .to_return(body: File.read("spec/sample_data/customers_all.json"))
        customers = Stripe::Customer.all(limit=3)
        customers.should_not be_nil
        customers.data.length.should eq(2)
      end
    end
  end

  describe "the create() method" do
    it "exists" do
      Stripe::Customer.responds_to?(:create).should be_true
    end
  end
end
