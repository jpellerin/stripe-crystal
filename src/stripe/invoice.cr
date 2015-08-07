require "./resource"

module Stripe
  class Invoice < Resource
    required id, String
    required object, String
    required livemode, Bool
    required amount_due, Int64
    required attempt_count, Int64
    required attempted, Bool
    

  
    jsonify!
  end
  
end