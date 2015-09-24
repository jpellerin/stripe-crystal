require "./resource"

module Stripe
  class ApplicationFee < Resource
    properties(required: {
      id: String,
      object: String
    })
  end
  
end
