require "json"
require "./resource"

module Stripe
  class Source < Resource

    required object, String

    jsonify!
  end

end
