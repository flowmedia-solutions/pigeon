module Pigeon
  class VoidRequest < SharedRequest
    def initialize(data = {})
      super()
      @postdata.merge!({
        'TxType' => 'VOID'
      }).merge!(data)
      @url = Pigeon.void_url
    end

    def perform
      OkableResponse.new(perform_post @url, @postdata)
    end
  end
end