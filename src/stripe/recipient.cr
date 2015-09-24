require "./resource"

module Stripe
  class Recipient < Resource
    properties(
      required: {
        id: String,
        object: String,
        livemode: Bool,
        created: Int64
      },
      present: {
        name: String,
        email: String,
        metadata: Metadata
      },
      optional: {
        description: String,
        type: String,
        active_account: BankAccount,
        cards: List(Card),
        default_card: Ref(Card),
        migrated_to: String
      }
    )
  end
end