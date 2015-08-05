require "./dsl"


# todo support subresources properly

module Stripe
  class Resource
    include Stripe::DSL

    def self.get(id : String)
      url = "https://api.stripe.com/v1/#{@@collection}/#{id}"
      resp = HTTP::Client.get(url)
      self.from_json(resp.body)
    end

    def self.all(limit=0)
      # FIXME
      # HEADERS
      # Error handling and junk
      url = "https://api.stripe.com/v1/#{@@collection}?limit=#{limit}"
      resp = HTTP::Client.get(url)
      List(self).from_json(resp.body)
    end

  end

   class List(T)
     json_mapping({object: String,
                   url: String,
                   has_more: Bool,
                   data: Array(T)})
   end
end
