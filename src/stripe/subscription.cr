require "./resource"

module Stripe
  class Subscription < Resource

    required id, String
    required object, String

    jsonify!

  end
end
