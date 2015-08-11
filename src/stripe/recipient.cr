require "./resource"

module Stripe
  class Recipient < Resource
    required id, String
    required object, String
    required livemode, Bool
    required created, Int64
    present name, String
    present email, String
    optional description, String
    #optional metadata, Hash(String,JSON::Any)
    optional :type, String
    optional active_account, BankAccount
    optional cards, List(Card)
    optional default_card, Ref(Card)
    optional migrated_to, String

    jsonify!
  end
end