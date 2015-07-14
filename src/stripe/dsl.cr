module Stripe::DSL

  macro required(name, type)
    register_property {{name}}, {{type}}
  end

  macro optional(name, type)
    register_property {{name}}, {{type}}}|Nil
  end

  macro register_property(name, type)
    {{name}} :: {{type}}
    property {{name}}
  end
end
