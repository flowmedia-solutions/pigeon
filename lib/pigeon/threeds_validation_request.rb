module Pigeon
  class ThreedsValidationRequest < Request
    def initialize(data = {})
      super()
      @postdata.merge! data
      @url = Pigeon.threeds_url
    end
  end
end