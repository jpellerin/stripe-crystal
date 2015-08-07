require "./resource"

module Stripe
  class Discount < Resource
    required id, String
    required object, String

    required customer, Ref(Customer)
    required coupon, Coupon
    required start, Int64
    required :end, Int64
    optional subscription, Ref(Subscription)
  
    jsonify!
  end
  
end