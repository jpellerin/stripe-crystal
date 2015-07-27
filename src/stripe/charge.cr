require "./resource"
require "./source"
require "./refund"

module Stripe
  class Charge < Resource
    required id, String
    required object, String
    required created, Int64  # FIXME date wrapper type?
    required livemode, Bool
    required amount, Int64
    required currency, String  # FIXME currency obj?
    optional customer, String # FIXME Id type?
    optional source, Source # FIXME SourceOrID type that auto-resolves ids on access? ID class?
    optional description, String
    optional capture, Bool
    optional statement_desciptor, String
    optional receipt_email, String
    optional destination, String
    optional application_fee, Int64
    optional shipping, JSON::Any # Hash?
    optional paid, Bool
    optional status, String
    optional refunded, Bool
    optional captured, Bool
    optional balance_transaction, String # FIXME REF
    optional failure_message, String
    optional failure_code, String
    optional amount_refunded, Int64
    optional customer, String # FIXME REF
    optional invoice, String
    optional description, String
    optional dispute, String
    optional metadata, JSON::Any
    optional statement_descriptor, String
    optional fraud_details, JSON::Any
    optional receipt_email, String
    optional receipt_number, String
    optional shipping, JSON::Any # ?
    optional destination, JSON::Any # ?
    optional application_fee, JSON::Any #?
    optional transfer, JSON::Any #?
    optional refunds, List(Refund)

    jsonify!

    def initialize
    end
  end
end
