require "./resource"

module Stripe
  class Refund < Resource
    required id, String

    jsonify!
  end
end
