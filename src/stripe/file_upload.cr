require "./resource"

module Stripe
  class FileUpload < Resource
    required id, String
    required object, String


  
    jsonify!
  end
  
end