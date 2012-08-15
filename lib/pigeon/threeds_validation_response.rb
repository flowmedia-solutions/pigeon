module Pigeon
  class ThreedsValidationResponse < Response
    def success?
      super && to_hash['Status'] == 'OK'
    end
  end
end