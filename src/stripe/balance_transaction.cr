require "./resource"

module Stripe
  class BalanceTransaction < Resource
    properties(required: {
      id: String,
      object: String
    })
  end

end
