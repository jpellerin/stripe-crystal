require "json"
require "./conversion"

module Stripe::DSL

  macro properties(required={} of Symbol => Hash(Symbol,_), present={} of Symbol => Hash(Symbol,_), optional={} of Symbol => Hash(Symbol,_))
    {% nils = {} of Symbol => Hash(Symbol,_) %}
    {% for key, vtype in present %}
      {% nils[key] = vtype %}
    {% end %}
      {% for key, vtype in optional %}
        {% nils[key] = vtype %}
      {% end %}
    {% for key, vtype in required %}
      def {{key.id}}=(_{{key.id}} : {{vtype.id}})
        @{{key.id}} = _{{key.id}}
      end

      def {{key.id}} : {{vtype.id}}
        @{{key.id}}
      end
    {% end %}
    {% for key, vtype in nils %}
      def {{key.id}}=(_{{key.id}} : {{vtype.id}}?)
        @{{key.id}} = _{{key.id}}
      end

      def {{key.id}} : {{vtype.id}}?
        @{{key.id}}
      end
    {% end %}

    # init from json
    def initialize(_pull : JSON::PullParser)
      {% for key, _v in required %}
        _{{key.id}} = nil
      {% end %}

      {% for key, _v in nils %}
        _{{key.id}} = nil
      {% end %}

      _pull.read_object do |_key|
        case _key
        {% for key, vtype in required %}
        when {{key.id.stringify}}
          _{{key.id}} = {{vtype}}.new(_pull)
        {% end %}
        {% for key, vtype in nils %}
        when {{key.id.stringify}}
          _{{key.id}} = _pull.read_null_or { {{vtype}}.new(_pull) }
        {% end %}
        else
          _pull.skip
        end
      end

      {% for key, _v in required %}
        if _{{key.id}}.is_a?(Nil)
          raise JSON::ParseException.new("missing json attribute: {{key.id}}", 0, 0)
        end
      {% end %}

      {% for key, _v in required %}
        @{{key.id}} = _{{key.id}}
      {% end %}
      {% for key, _v in nils %}
        @{{key.id}} = _{{key.id}}
      {% end %}
    end

    # init from hash
    def initialize(_obj : Hash(String, JSON::Type))
      {% for key, _v in required %}
        _{{key.id}} = nil
      {% end %}

      {% for key, _v in nils %}
        _{{key.id}} = nil
      {% end %}

      {% for key, vtype in required %}
        if _obj.has_key?({{key.id.stringify}})
          _{{key.id}} = {{vtype.id}}.from(_obj["{{key.id}}"])
        else
          raise ArgumentError.new("missing required key {{key.id}}")
        end
      {% end %}

      {% for key, vtype in nils %}
        if _obj.has_key?({{key.id.stringify}})
          _{{key.id}} = {{vtype.id}}.from(_obj["{{key.id}}"])
        end
      {% end %}

      {% for key, _v in required %}
        if _{{key.id}}.is_a?(Nil)
          raise ArgumentError.new("missing required key {{key.id}}")
        end
        @{{key.id}} = _{{key.id}}
      {% end %}

      {% for key, _v in nils %}
        @{{key.id}} = _{{key.id}}
      {% end %}
    end

    # to_json
    def to_json(io : IO)
      io.json_object do |json|
        {% for key, _v in required %}
          _{{key.id}} = @{{key.id}}
          json.field({{key.id.stringify}}) do
            _{{key.id}}.to_json(io)
          end
        {% end %}
        {% for key, _v in present %}
          _{{key.id}} = @{{key.id}}
          json.field({{key.id.stringify}}) do
            _{{key.id}}.to_json(io)
          end
        {% end %}
        {% for key, _v in optional %}
          _{{key.id}} = @{{key.id}}
          unless _{{key.id}}.is_a?(Nil)
            json.field({{key.id.stringify}}) do
              _{{key.id}}.to_json(io)
            end
          end
        {% end %}
      end
    end
  end

end
