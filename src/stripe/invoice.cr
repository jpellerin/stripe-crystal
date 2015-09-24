require "./resource"

module Stripe
  class Invoice < Resource
    properties(
      required: {
        id: String,
        object: String,
        livemode: Bool,
        amount_due: Int64,
        attempt_count: Int64,
        attempted: Bool
      }
    )
  end
  
end