require "./source"

module Stripe
  class BitcoinReceiver < Source

    required id, String

    jsonify!
  end
end
