require "./spec_helper"

describe Stripe::Charge do
  describe "properties" do
    it "exists" do
      c = Stripe::Charge.new
      c.responds_to?(:id).should be_true
      c.responds_to?(:created).should be_true
      c.responds_to?(:livemode).should be_true
    end

    it "emits json including the values of set properties" do
      c = Stripe::Charge.new
      c.id = "hi"
      h = JSON.parse(c.to_json)
      h.should_not be_nil
      if h
        h_h = h as Hash(String,JSON::Type)
        h_h["id"].should eq("hi")
      end
    end

    it "can be instantiated from minimal json" do
      c = Stripe::Charge.from_json(%({"id":"1",
                                      "object":"o",
                                      "created":1,
                                      "livemode":false,
                                      "amount": 0,
                                      "currency": "usd"}))
      c.id.should eq("1")
      c.object.should eq("o")
      c.created.should eq(1)
      c.livemode.should eq(false)
    end

    it "can be instantiated from sample data" do
      data = File.read("spec/sample_data/charge.json")
      c = Stripe::Charge.from_json(data)
      c.id.should eq("ch_16R30N2eZvKYlo2Cc9UqyVES")
    end

  end

end
