require "./dsl"


# todo support subresources properly

module Stripe
  class Resource
    include Stripe::DSL

    def self.get(id : String)
      url = "https://api.stripe.com/v1/#{@@collection}/#{id}"
      resp = HTTP::Client.get(url)
      self.from_json(resp.body)
    end

    def self.all(limit=0)
      # FIXME
      # HEADERS
      # Error handling and junk
      url = "https://api.stripe.com/v1/#{@@collection}?limit=#{limit}"
      resp = HTTP::Client.get(url)
      List(self).from_json(resp.body)
    end

    def self.from(x)
      raise "No conversion available from #{x} to #{self}"
    end
  end

  class List(T)
    # include Stripe::DSL

    # required object, String
    # required url, String
    # required has_more, Bool
    # required data, Array(T)

    # jsonify!
    json_mapping({
      object: String,
      url: String,
      has_more: Bool,
      data: Array(T)
      })
    
    def initialize(_pull : JSON::PullParser)
      obj = JSON::Any.new(_pull) as Hash(String,JSON::Type)
      object = String.from(obj["object"])
      url = String.from(obj["url"])
      has_more = Bool.from(obj["has_more"])
      data = obj["data"] as Array(JSON::Type)
      initialize object, url, has_more, data
    end

    def initialize(@object : String, @url : String, @has_more : Bool, _data : Array(JSON::Type))
      @data = Array(T).new
      _data.each do |h|
        @data << T.from(h)
      end
    end

    def self.from(h : Hash(String,JSON::Type))
      self.new String.from(h["object"]), String.from(h["url"]), Bool.from(h["has_more"]), h["data"] as Array(JSON::Type)
    end

    def self.from(x)
      raise ArgumentError.new "No conversion available from #{x} to #{self}"
    end
  end
end
