require "./resource"

module Stripe
  class FeeRefund < Resource
    required id, String
    required object, String


  
    jsonify!
  end
  
end