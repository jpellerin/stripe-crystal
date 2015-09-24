require "./source"

module Stripe
  class BitcoinReceiver < AbstractSource
    properties(
      required: {
        id: String,
        object: String,
        livemode: Bool,
        active: Bool,
        amount: Int64,
        amount_received: Int64,
        bitcoin_amount: Int64,
        bitcoin_amount_received: Int64,
        bitcoin_uri: String,
        created: Int64,
        currency: String,
        filled: Bool,
        inbound_address: String,
        uncaptured_funds: Bool,
        email: String
      },
      present: {
        metadata: Metadata
      },
      optional: {
        payment: String, # FIXME ref?
        customer: Ref(Customer),
        description: String,
        refund_address: String,
        # transactions: List(???)
      }
    )

  end
end
