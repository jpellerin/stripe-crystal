require "./json"
require "./resource"

module Stripe
  class Customer < Resource
    @@collection = "customers"

    properties(
      required: {
        id: String,
        object: String,
        created: Int64,
        livemode: Bool
      },
      present: {
        description: String,
        email: String,
        delinquent: Bool,
        metadata: Metadata,
        subscriptions: List(Subscription),
        account_balance: Int64,
        currency: String,
        discount: Ref(Discount),
        sources: List(Source),
        default_source: Ref(Source)
      }
    )
  end
end
