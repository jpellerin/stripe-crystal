require "./resource"

module Stripe
  class TransferReversal < Resource
    required id, String
    required object, String


  
    jsonify!
  end
  
end