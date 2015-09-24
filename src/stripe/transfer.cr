require "./resource"

module Stripe
  class Transfer < Resource
    properties(
      required: {
        id: String,
        object: String
      }
    )
  end
  
end