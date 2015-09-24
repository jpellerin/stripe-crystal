require "./dsl"
require "./source"

module Stripe
  class Card < AbstractSource
    properties(
      required: {
        id: String,
        object: String,
        last4: String,
        brand: String,
        funding: String,
        exp_month: Int64,
        exp_year: Int64,
        country: String,
        name: String
      },
      present: {
        customer: Ref(Customer),
        recipient: Ref(Recipient),
        address_line1: String,
        address_line2: String,
        address_city: String,
        address_state: String,
        address_country: String,
        cvc_check: String,
        address_line1_check: String,
        address_zip_check: String,
        tokenization_method: String,
        dynamic_last4: String,
        metadata: Metadata
      }
    )
    
  end
end
