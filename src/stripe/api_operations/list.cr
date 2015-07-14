module Stripe
  module APIOperations
    module List

      def all(filters : Hash(String,String), opts=nil : Nil) 
        all(filters, {} of String => String)
      end

      def all(filters : Hash(String,String), opts : Hash(String,String))
        opts = Util.normalize_opts(opts)
        response, opts = request(:get, url, filters, opts)
        Util.convert_to_stripe_object(response, opts)
      end
    end
  end
end
