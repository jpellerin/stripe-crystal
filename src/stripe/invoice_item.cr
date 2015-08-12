require "./resource"

module Stripe
  class InvoiceItem < Resource
    required id, String
    required object, String


  
    jsonify!
  end
  
end