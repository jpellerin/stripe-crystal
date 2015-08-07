require "./resource"

module Stripe
  class Refund < Resource
    @@collection = "refunds"

    required id, String
    required object, String
    required amount, Int64
    required created, Int64
    required currency, String
    present metadata, JSON::Any
    present balance_transaction, String # FIXME REF
    present charge, String # not a ref?
    present description, String
    present reason, String
    present receipt_number, String

    jsonify!

  end
end
