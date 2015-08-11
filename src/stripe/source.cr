require "json"
require "./resource"

module Stripe
  class AbstractSource < Resource end
  class Source < Resource

    def id=(_id : String)
      @id = _id
    end

    def id : String
      @id
    end

    def object=(_object : String)
      @object = _object
    end

    def object : String
      @object
    end

    def card=(c : Card?)
      @card = c
    end

    def card : Card?
      @card
    end

    def bitcoin_receiver=(b : BitcoinReceiver?)
      @bitcoin_receiver = b
    end

    def bitcoin_receiver : BitcoinReceiver?
      @bitcoin_receiver
    end

    def initialize(_pull : JSON::PullParser)
      puts "Source from_json called"
      obj = JSON::Any.new(_pull)
      if obj
        h_obj = obj as Hash(String,JSON::Type)
        initialize h_obj
      end
    end

    def initialize(obj : Hash(String,JSON::Type))
      @id = String.from(obj["id"])
      @object = String.from(obj["object"])
      case @object
      when "card"
        @card = Card.from obj
      when "bitcoin_receiver"
        @bitcoin_receiver = BitcoinReceiver.from obj
      else
        raise ArgumentError.new "Unknown source object #{@object}"
      end
    end

    def self.from(o : Hash(String,JSON::Type))
      puts "Source from called"
      new o
    end

  end

end
