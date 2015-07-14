require "./spec_helper"

describe Stripe do
  describe Stripe::Util do
    describe "normalize_opts" do
      it "should reject nil keys" do
        expect_raises ArgumentError, /must be a string/ do
          Stripe::Util.normalize_opts({api_key: nil})
        end
      end
    end
  end
end
