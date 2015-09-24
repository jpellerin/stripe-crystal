require "./resource"

module Stripe
  class Balance < Resource
    properties(required: {
      id: String,
      object: String
    })
  end

end
