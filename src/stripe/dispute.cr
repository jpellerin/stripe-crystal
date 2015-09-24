require "./resource"

module Stripe
  class Dispute < Resource
    properties(
      required: {
        id: String,
        object: String
      }
    )
    
  end
  
end