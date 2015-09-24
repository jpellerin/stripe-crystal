require "./resource"

module Stripe
  class Refund < Resource
    @@collection = "refunds"

    properties(
      required: {
        id: String,
        object: String,
        amount: Int64,
        created: Int64,
        currency: String
      },
      present: {
        metadata: Metadata,
        balance_transaction: String, # FIXME REF
        charge: String, # XXX is this a ref?
        description: String,
        reason: String,
        receipt_number: String
      }
    )

  end
end
