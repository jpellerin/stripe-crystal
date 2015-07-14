require "./api_operations"

module Stripe
  class APIResource
    extend Stripe::APIOperations::Request

    property! id
    property! values
    forward_missing_to @values

    def initialize(@id : String?, @opts)
      @retrieve_params = {} of String => String
      @values = {} of String => Opts
    end

    def initialize(@id : String?)
      @retrieve_params = {} of String => String
      @opts = {} of String => Opts
      @values = {} of String => Opts
    end

    def initialize(@retrieve_params : Hash(String, String))
      @id = @retrieve_params.fetch("id")
      @opts = {} of String => Opts
      @values = {} of String => Opts
    end

    def request(method, url)
      request(method, url, {} of String => Opts, {} of String => Opts)
    end

    def request(method, url, params)
      request(method, url, params, {} of String => Opts)
    end

    def request(method, url, params, opts)
      opts = @opts.merge(Util.normalize_opts(opts))
      self.class.request(method, url, params, opts)
    end

    def refresh
      response, opts = request(:get, url, @retrieve_params)
      refresh_from(response, opts)
    end

    def refresh_from(values, @opts, partial=false)
      if partial && @values
        @values.merge(values)
      else
        @values = values
      end
    end

    def url
      unless id = self.id?
        raise InvalidRequestError.new("Could not determine which URL to request: #{self.class} instance has invalid ID: #{id.inspect}", "id")
      end
      "#{self.class.url}/#{Util.escape(id)}"
    end

    def self.construct_from(values, opts)
      self.new(values.fetch("id")).refresh_from(values, opts)
    end

    def self.construct_from(values)
      self.construct_from(values, {} of String => String)
    end

    def self.class_name
      self.name.split("::")[-1]
    end

    def self.url
      "/v1/#{Util.escape(class_name.downcase)}s"
    end

    def self.retrieve(id, opts)
      opts = Util.normalize_opts(opts)
      instance = self.new(id, opts)
      instance.refresh
      instance
    end
  end
end
