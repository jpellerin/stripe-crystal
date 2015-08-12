require "./resource"

module Stripe
  class Token < Resource
    required id, String
    required object, String


  
    jsonify!
  end
  
end