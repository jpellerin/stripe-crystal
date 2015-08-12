require "./resource"

module Stripe
  class Balance < Resource
    required id, String
    required object, String


  
    jsonify!
  end
  
end