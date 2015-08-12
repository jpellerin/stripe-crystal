require "json"

module Stripe
  class Metadata

    def initialize(_pull : JSON::PullParser)
      k = JSON::Any.new _pull
      @values = k as Hash(String, JSON::Type)
    end

    def initialize(@values : Hash(String, JSON::Type))
    end

    def self.from(v : Hash(String, JSON::Type))
      new v
    end

    def self.from(x)
      raise ArgumentError.new "No conversion available to #{self} from #{x}"
    end

    forward_missing_to @values
  end
end