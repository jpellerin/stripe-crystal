require "./util"

module Stripe
  module RestClient
    class Error < Exception
    end

    class ErrorWithResponse < Error
      property http_code, http_body
    end

    class Request
      property method, url, params, headers, open_timeout, timeout, verify_ssl, ssl_ca_file

      def initialize(@method=:get, @url="", @params=nil,
                     @open_timeout=nil, @timeout=nil, @ssl_verify=false,
                     @ssl_ca_file=nil, @headers={} of String => String)
      end

      def execute
        case @method
        when :get, :head, :delete
          # Make params into GET parameters
          @params.try { |p|
            @url += "#{URI.parse(url).query ? "&" : "?"}#{uri_encode(p)}" if !p.empty?
          }
          @payload = nil
        else
          if @headers["content_type"] && @headers["content_type"] == "multipart/form-data"
            @payload = @params
          else
            @params.try { |p| @payload = uri_encode(p) }
          end
        end
      end

      def uri_encode(params : Hash(String,String))
        Util.flatten_params(params).
          map { |k,v| "#{k}=#{Util.url_encode(v)}" }.join('&')
      end


    end
  end
end
