require "./resource"

module Stripe
  class Ref(T) < Resource

    def initialize(pull : JSON::PullParser)
      @id = pull.read_string
      @ref = nil
    end

    def resolve
      r = @ref
      if r
        r
      else
        get(T, @id)
      end
    end

    def ref=(obj : T?)
      @ref = obj
    end

    def ref : T?
      @ref
    end

    def to_json(io : IO)
      if @ref
        @ref.to_json(io)
      else
        @id.to_json(io)
      end
    end

    def get(type, id : String)
      type.get(id)
    end
  end
end
