require "./resource"

module Stripe
  class Coupon < Resource
    required id, String
    required object, String
    required livemode, Bool
    required created, Int64
    required duration, String
    required times_redeemed, Int64
    required valid, Bool
    required amount_off, Int64
    required currency, String
    required duration_in_months, Int64
    required max_redemptions, Int64
    required percent_off, Int64
    required redeem_by, Int64
    
    optional metadata, Hash(String,String) # fixme too restrictive

    
  
    jsonify!
  end
  
end