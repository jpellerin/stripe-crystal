require "./resource"

module Stripe
  class Dispute < Resource
    required id, String
    required object, String


  
    jsonify!
  end
  
end