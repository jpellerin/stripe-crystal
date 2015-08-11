require "./resource"

module Stripe
  class Ref(T) < Resource

    def self.from(s : String)
      self.new s
    end

    def self.from(obj : Hash(String, JSON::Type))
      self.new T.from obj
    end

    def self.from(n : Nil)
      n
    end

    def self.from(x)
      pp x
      raise ArgumentError.new "Invalid type for #{self}: #{x}"
    end

    def initialize(@id : String)
    end

    def initialize(@ref : T?)
      r = @ref
      if r
        @id = r.id
      end
    end

    def initialize(pull : JSON::PullParser)
      case pull.kind
      when :string
        @id = String.new pull
        @ref = nil
      when :begin_object
        obj = T.new pull
        id = obj.id
        if id
          @id = id
          @ref = obj
        else
          raise ArgumentError.new "No id field in #{obj}"
        end
      else
        raise ArgumentError.new "Expected string or begin_object but got #{pull.kind}"
      end
    end

    def resolve
      r = @ref
      if r
        r
      else
        @ref = get(T, @id)
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

    def get(type, id : String?)
      id.try { |val| type.get(val) }
    end

    # Delegate to @refvia try{}
    macro method_missing(name, args, block)
      @ref.try { |o|
        o.{{name.id}}({{*args}}) {{ block }}
      }
    end
  end
end
