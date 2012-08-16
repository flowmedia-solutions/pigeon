module Pigeon
  class RefundRequest < SharedRequest
    def initialize(data = {})
      super()
      @postdata.merge!({
        'TxType' => 'REFUND'
      }).merge!(data)
      @url = Pigeon.refund_url
    end

    def perform
      OkableResponse.new(perform_post @url, @postdata)
    end
  end
end