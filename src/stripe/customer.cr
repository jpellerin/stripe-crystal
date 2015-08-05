require "./json"
require "./resource"

module Stripe
  class Customer < Resource
    @@collection = "customers"

    required id, String
    required object, String
    required created, Int64  # FIXME date wrapper type?
    required livemode, Bool

    present description, String
    present email, String
    present delinquent, Bool
    present metadata, JSON::Any # FIXME hash string -> any
    present subscriptions, List(Subscription)
    present account_balance, Int64
    present currency, String
    present discount, JSON::Any # FIXME discount obj
    present sources, JSON::Any # list of card or bitcoin receiver
    present default_source, String

    jsonify!

  end
end
