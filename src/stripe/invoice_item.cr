require "./resource"

module Stripe
  class InvoiceItem < Resource
    properties(
      required: {
        id: String,
        object: String
      }
    )
  end
  
end