require "./resource"

module Stripe
  class Token < Resource
    properties(
      required: {
        id: String,
        object: String
      }
    )
  end
  
end