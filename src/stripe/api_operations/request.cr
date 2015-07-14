module Stripe

  alias Opts = String | Hash(String, String) | Hash(String, Int32)

  module APIOperations
    module Request
      
      OPTS_KEYS_TO_PERSIST = Set["api_key", "api_base", "stripe_account", "stripe_version"]

      def request(method, url)
        request(method, url, {} of String => Opts, {} of String => Opts)
      end

      def request(method, url, params)
        request(method, url, params, {} of String => Opts)
      end

      def request(method, url, params, opts)
        opts = Util.normalize_opts(opts)

        headers = opts.clone
        api_key = headers.delete("api_key")
        api_base = headers.delete("api_base")
        # Assume all remaining opts must be headers

        response, opts["api_key"] = Stripe.request(
          method, url, api_key, params, headers, api_base)

        opts_to_persist = {} of String => Opts
        opts.each do |k, v|
          if OPTS_KEYS_TO_PERSIST.include?(k)
            opts_to_persist[k] = v
          end
        end

        [response, opts_to_persist]
      end
    end
  end
end
