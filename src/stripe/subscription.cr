require "./resource"

module Stripe
  class Subscription < Resource

    required id, String
    required object, String
    required customer, Ref(Customer)
    required plan, Plan
    required quantity, Int64
    required start, Int64
    required status, String
    required current_period_start, Int64
    required current_period_end, Int64

    optional trial_start, Int64
    optional trial_end, Int64
    optional discount, Discount
    optional ended_at, Int64
    optional tax_percent, Float64  # fixme decimal
    optional application_fee_percent, Float64 # fixme decimal
    optional canceled_at, Int64
    present metadata, Metadata

    jsonify!

  end
end
