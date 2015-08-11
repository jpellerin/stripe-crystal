require "./resource"

module Stripe
  class BankAccount < Resource
    required id, String
    required object, String


  
    jsonify!
  end
  
end