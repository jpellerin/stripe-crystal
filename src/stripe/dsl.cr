module Stripe::DSL

  # XXX todo(jhp) support hash(string,any) correctly
  # make sure semantics of optional and present make sense

  macro jsonify!
    {% properties = {} of String => Hash(_,_) %}
    {% for meth in @type.methods %}
      {% name = meth.name.stringify %}
      {% if name.starts_with?("json__prop_") %}
        {% properties[name[11..-1]] = {type: meth.args[0].default_value.id, nilable: meth.args[1].default_value.id, emit_null: meth.args[2].default_value.id} %}
      {% end %}
    {% end %}

    json_mapping({{properties}}, true)
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
