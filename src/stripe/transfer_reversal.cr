require "./resource"

module Stripe
  class TransferReversal < Resource
    properties(
      required: {
        id: String,
        object: String
      }
    )
  end
  
end