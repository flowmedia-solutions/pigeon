module Pigeon
  class ThreedsValidationRequest < Request
    def initialize(data = {})
      super()
      @postdata.merge! data
      @url = Pigeon.threeds_url
    end
    
    def perform
      OkableResponse.new(perform_post @url, @postdata)
    end
  end
end