require "./resource"

module Stripe
  class Discount < Resource
    properties(
      required: {
        id: String,
        object: String,
        customer: Ref(Customer),
        coupon: Coupon,
        start: Int64,
        :end => Int64,
        subscription: Ref(Subscription)
      }
    )
    
  end
  
end