module Pigeon
  class VoidRequest < SharedRequest
    def initialize
      super
      @url = Pigeon.void_url
    end

    def perform
      OkableResponse.new(perform_post @url, @postdata)
    end
  end
end