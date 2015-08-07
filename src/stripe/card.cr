require "./dsl"
require "./source"

module Stripe
  class Card < Source

    required id, String
    required object, String
    required last4, String
    required brand, String
    required funding, String
    required exp_month, Int64
    required exp_year, Int64
    required country, String
    required name, String
    
    optional customer, Ref(Customer)
    optional recipient, Ref(Recipient)
    optional address_line1, String
    optional address_line2, String
    optional address_city, String
    optional address_state, String
    optional address_country, String
    optional cvc_check, String
    optional address_line1_check, String
    optional address_zip_check, String
    optional tokenization_method, String
    optional dynamic_last4, String
    optional metadata, Hash(String,String)

    jsonify!
  end
end
