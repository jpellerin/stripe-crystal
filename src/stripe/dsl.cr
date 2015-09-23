require "json"
require "./conversion"

module Stripe::DSL

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
      {% if _def[:nilable] %}
        {% vtype = value.id + "?" %}
      {% else %}
        {% vtype = value.id %}
      {% end %}

      def {{key.id}}=(_{{key.id}} : {{vtype}})
        @{{key.id}} = _{{key.id}}
      end

      def {{key.id}} : {{vtype}}
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
            {{_def[:type]}}.new(_pull)
            {% if _def[:nilable] == true %} } {% end %}
        {% end %}
        else
          _pull.skip
        end
      end

      {% for key, _def in defs %}
        {% unless _def[:nilable] %}
          if _{{key.id}}.is_a?(Nil)
            raise JSON::ParseException.new("missing json attribute: {{key.id}}", 0, 0)
          end
        {% end %}
      {% end %}

      {% for key, _def in defs %}
        @{{key.id}} = _{{key.id}}
      {% end %}
    end

    # init from hash
    def initialize(_obj : Hash(String, JSON::Type))
      {% for key, _def in defs %}
        _{{key.id}} = nil
      {% end %}

      {% for key, _def in defs %}
        {% value = _def[:type] %}
        if _obj.has_key?({{key.id.stringify}})

          _{{key.id}} = {{value.id}}.from(_obj["{{key.id}}"])
        end
      {% end %}

      {% for key, _def in defs %}
        {% unless _def[:nilable] %}
          if _{{key.id}}.is_a?(Nil)
            raise JSON::ParseException.new("missing json attribute: {{key.id}}", 0, 0)
          end
        {% end %}
      {% end %}

      {% for key, _def in defs %}
        @{{key.id}} = _{{key.id}}
      {% end %}
      {{debug()}}
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

    def self.from(_pull : JSON::PullParser)
      new _pull
    end

    def self.from(_obj : Hash(String,JSON::Type))
      new _obj
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
end
