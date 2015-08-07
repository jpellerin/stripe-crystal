require "./resource"

module Stripe
  class Plan < Resource
    required id, String
    required object, String
    required livemode, Bool
    required amount, Int64
    required created, Int64
    required currency, String
    required interval, String
    required interval_count, Int64
    required name, String
    present statement_descriptor, String
    present trial_period_days, Int64
    
    optional metadata, Hash(String,String)

    jsonify!

  end
end