require "./resource"

module Stripe
  class Account < Resource
    required id, String
    required object, String


  
    jsonify!
  end
  
end