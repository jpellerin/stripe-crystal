require "./resource"

module Stripe
  class Event < Resource
    required id, String
    required object, String


  
    jsonify!
  end
  
end