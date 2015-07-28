require "./spec_helper"


describe Stripe::Refund do
  describe "properties" do
    it "exists" do
      r = Stripe::Refund.new
      r.responds_to?(:id).should be_true
      r.responds_to?(:created).should be_true
      r.responds_to?(:amount).should be_true
      r.responds_to?(:object).should be_true
      r.responds_to?(:currency).should be_true
    end

    it "emits json including the values of set properties" do
      r = Stripe::Refund.new
      r.id = "hi"
      h = JSON.parse(r.to_json)
      h.should_not be_nil
      if h
        h_h = h as Hash(String,JSON::Type)
        h_h["id"].should eq("hi")
      end
    end

    it "can be instantiated from minimal json" do
      r = Stripe::Refund.from_json(%({"id":"1",
                                      "object":"o",
                                      "created":1,
                                      "amount": 0,
                                      "currency": "usd"}))
      r.id.should eq("1")
      r.object.should eq("o")
      r.created.should eq(1)
      r.amount.should eq(0)
      r.currency.should eq("usd")
    end

    it "can be instantiated from sample data" do
      data = File.read("spec/sample_data/refund.json")
      r = Stripe::Refund.from_json(data)
      r.id.should eq("re_16TTpq2eZvKYlo2CYLDWLqa4")
    end
  end
end
