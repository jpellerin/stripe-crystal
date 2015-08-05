require "json"

module Stripe::DSL

  # XXX todo(jhp) support hash(string,any) correctly
  # make sure semantics of optional and present make sense
  class Prop
    def initialize(@type, @required, @nilable)
    end
  end

  macro jsonify!
    {% properties = {} of String => Hash(Symbol,_) %}
    {% for meth in @type.methods %}
      {% name = meth.name.stringify %}
      {% if name.starts_with?("json__prop_") %}
      {% properties[name[11..-1]] =  {type: meth.args[0].default_value.id,
                                      nilable: meth.args[1].default_value.id,
                                      emit_null: meth.args[2].default_value.id} %}
      {% end %}
    {% end %}
    fields({{properties}})
  end

  macro fields(defs)
    # Getters and setters
    {% for key, _def in defs %}
    {% value = _def[:type] %}
    {% if value.is_a?(HashLiteral) %}
    {% vtype = value.values.join("|").id %}
    {% rtype = vtype + "|Nil" %}
    {% elsif _def[:nilable] %}
    {% vtype = value.id + "?" %}
    {% rtype = vtype %}
    {% else %}
    {% vtype = value.id %}
    {% rtype = vtype + "?" %}
    {% end %}
    def {{key.id}}=(_{{key.id}} : {{vtype}})
      @{{key.id}} = _{{key.id}}
    end

    def {{key.id}} : {{rtype}}
      @{{key.id}}
    end
    {% end %}

    # init from json
    def initialize(_pull : JSON::PullParser)
      {% for key, _def in defs %}
        _{{key.id}} = nil
      {% end %}

      _pull.read_object do |_key|
        case _key
        {% for key, _def in defs %}
        when {{key.id.stringify}}
          _{{key.id}} =
            {% if _def[:nilable] == true %} _pull.read_null_or { {% end %}
            {% if _def[:type].is_a?(HashLiteral) %}
            obj = JSON::Any.new(_pull) as Hash(String,JSON::Type)
            case obj["object"]?
            {% for object, klass in _def[:type] %}
            when {{object.id.stringify}}
              {{klass.id}}.new(obj)
            {% end %}
            else
              raise ArgumentError.new "Invalid object type #{obj["object"]}"
            end
            {% else %}
              {{_def[:type]}}.new(_pull)
            {% end %}
            {% if _def[:nilable] == true %} } {% end %}
        {% end %}
        else
          _pull.skip
        end
      end

      {% for key, _def in defs %}
        @{{key.id}} = _{{key.id}}
      {% end %}
    end

    # init from hash
    def initialize(_obj : Hash(String, JSON::Type))
      {% for key, _def in defs %}
        {% value = _def[:type] %}
        {% if value.is_a?(HashLiteral) %}
          o_val = _obj["{{key.id}}"]
          @{{key.id}} = case o_val
                        {% for object, klass in value %}
                        when {{object.id.stringify}}
                          klass.new(o_val)
                        {% end %}
                        else
                          nil
                        end
        {% else %}
          @{{key.id}} = _obj["{{key.id}}"]
        {% end %}
      {% end %}
    end

    # init from id
    def initialize(@id : String)
    end

    # empty init
    def initialize
    end

    # to_json
    def to_json(io : IO)
      io.json_object do |json|
        {% for key, _def in defs %}
          _{{key.id}} = @{{key.id}}
          {% unless _def[:emit_null] %}
            unless _{{key.id}}.is_a?(Nil)
          {% end %}

          json.field({{key.id.stringify}}) do
            _{{key.id}}.to_json(io)

          end
          {% unless _def[:emit_null] %}
            end
          {% end %}
        {% end %}
      end
    end
  end

  macro required(name, type)
    register_property {{name}}, {{type}}, false, false
  end

  macro optional(name, type)
    register_property {{name}}, {{type}}, true, false
  end

  macro present(name, type)
    register_property {{name}}, {{type}}, true, true
  end

  macro register_property(name, type, nillable, emit_null)
    private def json__prop_{{name.id}}(t={{type}}, n={{nillable}}, e={{emit_null}})
    end
  end

  class Either
    def initialize(@opts)
    end

    def from(obj : Hash(String, JSON::Type))
      from(obj["object"]?, obj)
    end

    def from(typ : String, obj : Hash(String, JSON::Type))
      begin
        k = @opts[typ]
        puts k
      rescue e : KeyError
        raise ArgumentError.new "#{typ} is not a valid object type. Valid types: #{@opts}"
      else
        k.new(obj)
      end
    end

    def from(typ : String)
      puts "I got a string? #{typ}"
      # from(typ, {} of String => JSON::Type)
    end

    def from(typ : Nil)
      raise ArgumentError.new "No object type supplied"
    end

    def from(typ : Nil, obj)
      raise ArgumentError.new "Invalid object #{obj}: no type"
    end

    def from(what)
      puts "I don't know what I go #{what}"
    end

    def from(what, why)
      puts "I don't know what I got #{what} #{why}"
    end

    def from_json(_pull : JSON::PullParser)
      obj = JSON::Any.new _pull
      from(obj)
    end
  end
end
