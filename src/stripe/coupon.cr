require "./resource"

module Stripe
  class Coupon < Resource
    properties(
      required: {
        id: String,
        object: String,
        livemode: Bool,
        created: Int64,
        duration: String,
        times_redeemed: Int64,
        valid: Bool,
        currency: String,
        duration_in_months: Int64,
        max_redemptions: Int64,
        redeem_by: Int64
      },
      present: {
        amount_off: Int64,
        percent_off: Int64,
      },
      optional: {
        metadata: Metadata
      }
    )

  end

end
