module Stripe::DSL

  # XXX todo(jhp) include and handle emit_null

  macro resource!
    {% properties = {} of String => Hash(_,_) %}
    {% for meth in @type.methods %}
      {% name = meth.name.stringify %}
      {% if name.starts_with?("json__prop_") %}
        {% properties[name[11..-1]] = {type: meth.args[0].default_value.id, nillable: meth.args[1].default_value.id} %}
      {% end %}
    {% end %}

    json_mapping({{properties}}, true)
  end

  macro required(name, type)
    register_property {{name}}, {{type}}, false
  end

  macro optional(name, type)
    register_property {{name}}, {{type}}}|Nil, true
  end

  macro register_property(name, type, nillable)
    {{name.id}} :: {{type}}
    property {{name}}
    private def json__prop_{{name.id}}(t={{type}}, n={{nillable}})
    end
  end
end
