require "cgi"
require "json"
require "openssl"
require "socket"
require "uri"

require "./stripe/*"


alias Empty = Hash(String, String)

module Stripe
  DEFAULT_CA_BUNDLE_PATH = "data/ca-certificates.crt"
  @@api_base = "https://api.stripe.com"
  @@connect_base = "https://connect.stripe.com"
  @@uploads_base = "https://uploads.stripe.com"

  @@ssl_bundle_path  = DEFAULT_CA_BUNDLE_PATH
  @@verify_ssl_certs = true

  @@api_version = ""  # FIXME?

  def self.api_url(url : String, api_base_url : String?)
    (api_base_url || @@api_base) + url
  end

  # def self.request(method : Symbol, url : String, api_key : String?,
  #                  params : Hash(String, String), headers : Hash(String, String),
  #                  api_base_url=nil : String?)
  #   api_base_url = api_base_url || @@api_base
  #   request = Stripe::RestClient::Request.new method: method,
  #                                             open_timeout: 30,
  #                                             timeout: 80
  #   unless api_key ||= @@api_key
  #     raise AuthenticationError.new(%(No API key provided. \
  #       Set your API key using "Stripe.api_key = <API-KEY>". \
  #       You can generate API keys from the Stripe web interface. \
  #       See https://stripe.com/api for details, or email support@stripe.com \
  #       if you have any questions.))
  #   end

  #   if api_key =~ /\s/
  #     raise AuthenticationError.new("Your API key is invalid, as it contains " \
  #       "whitespace. (HINT: You can double-check your API key from the " \
  #       "Stripe web interface. See https://stripe.com/api for details, or " \
  #       "email support@stripe.com if you have any questions.)")
  #   end

  #   if @@verify_ssl_certs
  #     request.verify_ssl = true, # FIXME OpenSSL::SSL::VERIFY_PEER,
  #     request.ssl_ca_file = @@ssl_bundle_path
  #   else
  #     request.verify_ssl = false
  #     unless @@verify_ssl_warned
  #       @@verify_ssl_warned = true
  #       STDERR.puts(%(WARNING: Running without SSL cert verification. \
  #         You should never do this in production. \
  #         Execute "Stripe.verify_ssl_certs = true" to enable verification.))
  #     end
  #   end

  #   params = Util.objects_to_ids(params)
  #   url = api_url(url, api_base_url)

  #   request.headers = request_headers(api_key).merge(headers)
  #   request.params = params
  #   request.url = url

  #   begin
  #     response = request.execute
  #   rescue e : SocketError
  #     handle_restclient_error(e, api_base_url)
  #   rescue e : Stripe::RestClient::ErrorWithResponse
  #     rcode = e.http_code
  #     rbody = e.http_body
  #     if rcode && rbody
  #       handle_api_error(rcode, rbody)
  #     else
  #       handle_restclient_error(e, api_base_url)
  #     end
  #   rescue e : Stripe::RestClient::Error
  #     handle_restclient_error(e, api_base_url)
  #   rescue e : Errno
  #     if e.errno == Errno::ECONNREFUSED
  #       handle_restclient_error(e, api_base_url)
  #     else
  #       raise e
  #     end
  #   end

  #   {parse(response), api_key}
  # end

  def self.request_headers(api_key)
    headers = {
      "user_agent": "Stripe/v1 CrystalBindings/#{Stripe::VERSION}",
      "authorization": "Bearer #{api_key}",
      "content_type": "application/x-www-form-urlencoded"
    }

    headers["stripe_version"] = @@api_version if @@api_version

    begin
      headers.merge!({"x_stripe_client_user_agent": user_agent.to_json})
    rescue e
      headers.merge!({"x_stripe_client_raw_user_agent": user_agent.inspect,
                      "error": "#{e} (#{e.class})"})
    end
  end

  def self.user_agent
    @@uname ||= get_uname
    lang_version = "0.73"  # FIXME

    {
      bindings_version: Stripe::VERSION,
      lang: "crystal",
      lang_version: lang_version,
      platform: "FIXME",
      publisher: "stripe",
      uname: @@uname,
      hostname: "FIXME"
    }
  end

  def self.get_uname
    # FIXME
    "unknown platform"
  end

end
