require "./dsl"
require "./source"

module Stripe
  class Card < AbstractSource

    required id, String
    required object, String
    required last4, String
    required brand, String
    required funding, String
    required exp_month, Int64
    required exp_year, Int64
    required country, String
    required name, String
    
    present customer, Ref(Customer)
    present recipient, Ref(Recipient)
    present address_line1, String
    present address_line2, String
    present address_city, String
    present address_state, String
    present address_country, String
    present cvc_check, String
    present address_line1_check, String
    present address_zip_check, String
    present tokenization_method, String
    present dynamic_last4, String
    present metadata, Metadata

    jsonify!
  end
end
