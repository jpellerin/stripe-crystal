require "./resource"

module Stripe
  class Customer < Resource

    required id, String
    required object, String
    required created, Int64
    required id, String
    required livemode, Bool

    resource!

    def initialize
    end

    def self.all(limit=0)

    end
  end
end
