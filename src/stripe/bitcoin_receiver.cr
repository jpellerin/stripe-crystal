require "./source"

module Stripe
  class BitcoinReceiver < Source

    required id, String
    required object, String
    required livemode, Bool
    required active, Bool
    required amount, Int64
    required amount_received, Int64
    required bitcoin_amount, Int64
    required bitcoin_amount_received, Int64
    required bitcoin_uri, String
    required created, Int64
    required currency, String
    required filled, Bool
    required inbound_address, String
    required uncaptured_funds, Bool
    
    required email, String
    optional payment, String # fixme?
    optional customer, Ref(Customer)
    optional description, String
    optional refund_address, String
    optional metadata, Hash(String,String)
    
    # optional transactions, List # FIXME of what?

    jsonify!
  end
end
