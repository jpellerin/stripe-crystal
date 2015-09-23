require "./spec_helper"


describe Stripe::Charge do

  it "can be instantiated from sample data" do
    data = File.read("spec/sample_data/charge.json")
    c = Stripe::Charge.from_json(data)
    c.id.should eq("ch_16R30N2eZvKYlo2Cc9UqyVES")
  end

  it "should have non-nillable required fields" do
    data = File.read("spec/sample_data/charge.json")
    c = Stripe::Charge.from_json(data)
    c.id.gsub("VEW","yes").should eq("ch_16R30N2eZvKYlo2Cc9UqyVES")
  end

  describe "customer" do

    it "is a reference that can be resolved" do
      Fixtures::Charge.sample_data do |data|
        c = Stripe::Charge.from_json(data)
        cus = c.customer.try &.resolve

        cus.try { |o|
          o.id.should eq("cus_6eLh4evge7sWzQ")
          o.object.should eq("customer")
        }
      end
    end

    it "should delegate to the object once resolve" do
      Fixtures::Charge.sample_data do |data|
        c = Stripe::Charge.from_json(data)
        c.customer.try &.resolve
        c.customer.try { |cus|
          cus.id.should eq("cus_6eLh4evge7sWzQ")
          cus.object.should eq("customer")
        }
      end
    end
  end

  describe "the all() method" do
    it "exists" do
      Stripe::Charge.responds_to?(:all).should be_true
    end

    it "makes an api call" do
      WebMock.wrap do
        WebMock.stub(:get, "api.stripe.com/v1/charges?limit=3")
          .to_return(body: File.read("spec/sample_data/charges_all.json"))
        charges = Stripe::Charge.all(limit=3)
        charges.should_not be_nil
        charges.data.size.should eq(2)
      end
    end
  end

  describe "the create() method" do
    it "exists" do
      Stripe::Charge.responds_to?(:create).should be_true
    end
  end
end
