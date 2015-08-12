require "./resource"

module Stripe
  class BalanceTransaction < Resource
    required id, String
    required object, String

    # FIXME
  
    jsonify!
  end
  
end