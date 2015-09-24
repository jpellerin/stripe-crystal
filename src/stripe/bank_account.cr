require "./resource"

module Stripe
  class BankAccount < Resource
    properties(required: {
      id: String,
      object: String
    })
  end

end
