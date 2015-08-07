require "./spec_helper"


describe Stripe::Refund do

  it "can be instantiated from sample data" do
    data = File.read("spec/sample_data/refund.json")
    r = Stripe::Refund.from_json(data)
    r.id.should eq("re_16TTpq2eZvKYlo2CYLDWLqa4")
  end

end
