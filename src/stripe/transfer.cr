require "./resource"

module Stripe
  class Transfer < Resource
    required id, String
    required object, String

    # FIXME
  
    jsonify!
  end
  
end