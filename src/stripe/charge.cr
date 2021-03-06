require "./resource"

module Stripe
  class Charge < Resource
    @@collection = "charges"

    properties(
      required: {
         id: String,
         object: String,
         created: Int64,
         livemode: Bool,
         amount: Int64,
         currency: String,
         source: Source
       },
       present: {
         customer: Ref(Customer),
         description: String
       },
       optional: {
         metadata: Metadata
       }
    )

    # required id, String
    # required object, String
    # required created, Int64  # FIXME date wrapper type?
    # required livemode, Bool
    # required amount, Int64
    # required currency, String  # FIXME currency obj?
    # required source, Source
    # present customer, Ref(Customer)
    # present description, String
    # present capture, Bool
    # present statement_desciptor, String
    # present receipt_email, String
    # present destination, String # FIXME REF
    # present application_fee, Int64
    # present shipping, JSON::Any # Hash?
    # present paid, Bool
    # present status, String
    # present refunded, Bool
    # present captured, Bool
    # present balance_transaction, Ref(BalanceTransaction)
    # present failure_message, String
    # present failure_code, String
    # present amount_refunded, Int64
    # present invoice, Ref(Invoice)
    # present description, String
    # present dispute, String
    # present statement_descriptor, String
    # present fraud_details, JSON::Any
    # present receipt_email, String
    # present receipt_number, String
    # present shipping, JSON::Any # ?
    # present destination, JSON::Any # ?
    # present application_fee, JSON::Any #?
    # present transfer, Ref(Transfer)
    # present refunds, List(Refund)
    # optional metadata, Metadata

    # jsonify!

  end
end
