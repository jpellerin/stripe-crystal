require "./spec_helper"


describe Stripe::Customer do

  it "can be instantiated from sample data" do
    data = File.read("spec/sample_data/customer.json")
    c = Stripe::Customer.from_json(data)
    c.id.should eq("cus_6blhDTjCsoUECV")
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
