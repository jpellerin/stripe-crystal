require "./dsl"


# todo support subresources properly

module Stripe
  class Resource
    include Stripe::DSL

  end

  class List(T)
    json_mapping({object: String,
                  url: String,
                  has_more: Bool,
                  data: Array(T)})
  end
end
