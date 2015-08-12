require "./resource"

module Stripe
  class ApplicationFee < Resource
    required id, String
    required object, String


  
    jsonify!
  end
  
end