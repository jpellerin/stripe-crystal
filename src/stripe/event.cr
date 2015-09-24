require "./resource"

module Stripe
  class Event < Resource
    properties(
      required: {
        id: String,
        object: String
      }
    )
  end
  
end