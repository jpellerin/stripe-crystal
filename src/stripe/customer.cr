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
    present metadata, Metadata
    present subscriptions, List(Subscription)
    present account_balance, Int64
    present currency, String
    present discount, Ref(Discount)
    present sources, List(Source) # FIXME need a special type?
    present default_source, Ref(Source) # FIXME need a special type?

    jsonify!

  end
end
