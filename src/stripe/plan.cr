require "./resource"

module Stripe
  class Plan < Resource
    properties(
      required: {
        id: String,
        object: String,
        livemode: Bool,
        amount: Int64,
        created: Int64,
        currency: String,
        interval: String,
        interval_count: Int64,
        name: String,
      },
      present: {
        statement_descriptor: String,
        trial_period_days: Int64,
        metadata: Metadata
      }
    )
  end
end