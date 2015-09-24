require "./resource"

module Stripe
  class Account < Resource
    properties(required: {
      id: String,
      object: String
    })
  end

end
