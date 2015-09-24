require "./resource"

module Stripe
  class Subscription < Resource
    properties(
      required: {
        id: String,
        object: String,
        customer: Ref(Customer),
        plan: Plan,
        quantity: Int64,
        start: Int64,
        status: String,
        current_period_start: Int64,
        current_period_end: Int64
      },
      present: {
        metadata: Metadata
      },
      optional: {
        trial_start: Int64,
        trial_end: Int64,
        discount: Discount,
        ended_at: Int64,
        tax_percent: Float64, # FIXME decimal
        application_fee_percent: Float64, # FIXME decimal
        canceled_at: Int64
      }
    )
  end
end
