module Pigeon
  class VoidRequest < SharedRequest
    def initialize
      super
      @url = Pigeon.refund_url
    end

    def perform
      OkableResponse.new(perform_post @url, @postdata)
    end
  end
end