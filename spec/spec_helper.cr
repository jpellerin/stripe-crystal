require "json"
require "spec"
require "webmock"
require "../src/stripe"

module Fixtures
  module Charge
    extend self
    def sample_data
      data = File.read("spec/sample_data/charge.json")
      customer = File.read("spec/sample_data/customer2.json")

      WebMock.wrap {
        WebMock.stub(:get, "api.stripe.com/v1/customers/cus_6eLh4evge7sWzQ")
          .to_return(body: customer)
        yield data

      }
    end
  end
end
