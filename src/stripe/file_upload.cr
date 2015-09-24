require "./resource"

module Stripe
  class FileUpload < Resource
    properties(
      required: {
        id: String,
        object: String
      }
    )
  end
  
end