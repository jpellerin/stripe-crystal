require "./resource"

module Stripe
  class Source < Resource
    required id, String
    required object, String
    required customer, String  # FIXME REF to customer
    optional last4, String
    optional brand, String
    optional funding, String
    optional exp_month, Int32
    optional exp_year, Int32
    optional country, String
    optional name, String
    optional address_line1, String
    optional address_line2, String
    optional address_state, String
    optional address_city, String
    optional address_zip, String
    optional address_country, String
    optional cvc_check, String
    optional address_line1_check, String
    optional address_zip_check, String
    optional tokenization_method, String
    optional dynamic_last4, String
    optional metadata, JSON::Any

    jsonify!
  end
end
