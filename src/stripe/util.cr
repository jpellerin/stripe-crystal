require "cgi"

module Stripe
  module Util

    URI_UNRESERVED = "-_\\.!~*(){}a-zA-Z\\d"

    def self.objects_to_ids(h : Hash(String,String))
        res = {} of String => String
        h.each { |k, v| res[k] = objects_to_ids(v) unless v.nil? }
        res
    end

    def self.objects_to_ids(h : APIResource)
        h.id
    end
  
    def self.objects_to_ids(h : Array)
        h.map { |v| objects_to_ids(v) }
    end

    def self.objects_to_ids(h : String)
      h
    end

    def self.object_classes
      @@object_classes ||= {
        # # data structures
        # "list" => ListObject,

        # # business objects
        # "account" => Account,
        # "application_fee" => ApplicationFee,
        # "balance" => Balance,
        # "balance_transaction" => BalanceTransaction,
        # "bank_account" => BankAccount,
        # "card" => Card,
        # "charge" => Charge,
        # "coupon" => Coupon,
        # "customer" => Customer,
        # "event" => Event,
        # "fee_refund" => ApplicationFeeRefund,
        # "invoiceitem" => InvoiceItem,
        # "invoice" => Invoice,
        # "plan" => Plan,
        # "recipient" => Recipient,
        # "refund" => Refund,
        # "subscription" => Subscription,
        # "file_upload" => FileUpload,
        # "transfer" => Transfer,
        # "transfer_reversal" => Reversal,
        # "bitcoin_receiver" => BitcoinReceiver,
        # "bitcoin_transaction" => BitcoinTransaction
      } of String => APIResource
    end

    def self.convert_to_stripe_object(resp, opts)
      case resp
      when Array
        resp.map { |i| convert_to_stripe_object(i, opts) }
      when Hash
        # Try converting to a known object class.  If none available, fall back to generic StripeObject
        object_classes.fetch(resp[:object], StripeObject).construct_from(resp, opts)
      else
        resp
      end
    end

    def self.file_readable(file)
      # This is nominally equivalent to File.readable?, but that can
      # report incorrect results on some more oddball filesystems
      # (such as AFS)
      begin
        File.open(file) { |f| }
      rescue
        false
      else
        true
      end
    end

    def self.url_encode(key)
      CGI.escape(key.to_s)
    end

    def self.flatten_params(params, parent_key=nil)
      result :: Array(Array(String))
      params.each do |key, value|
        calculated_key = parent_key ? "#{parent_key}[#{url_encode(key)}]" : url_encode(key)
        if value.is_a?(Hash)
          result += flatten_params(value, calculated_key)
        elsif value.is_a?(Array)
          result += flatten_params_array(value, calculated_key)
        else
          result << [calculated_key, value]
        end
      end
      result
    end

    def self.flatten_params_array(value, calculated_key)
      result = [] of Array[String]
      value.each do |elem|
        if elem.is_a?(Hash)
          result += flatten_params(elem, calculated_key)
        elsif elem.is_a?(Array)
          result += flatten_params_array(elem, calculated_key)
        else
          result << ["#{calculated_key}[]", elem]
        end
      end
      result
    end

    # The secondary opts argument can either be a string or hash
    # Turn this value into an api_key and a set of headers
    def self.normalize_opts(opts: String)
        {"api_key": opts}
    end

    def self.normalize_opts(opts: Hash)
        check_api_key!(opts.fetch("api_key")) if opts.has_key?("api_key")
        opts.clone
    end

    def self.normalize_opts(opts: Nil)
      {} of String => Opts
    end

    def self.check_string_argument!(key)
      raise ArgumentError.new("argument must be a string") unless key.is_a?(String)
      key
    end

    def self.check_api_key!(key)
      raise ArgumentError.new("api_key must be a string") unless key.is_a?(String)
      key
    end

    def self.escape(s : String)
      s  # FIXME
    end
  end
end
