require "./resource"

module Stripe
  class FeeRefund < Resource
    properties(
      required: {
        id: String,
        object: String
      }
    )
  end
  
end