module Pigeon
  class Gateway
    def self.payment_request(req)
      if req.is_a? Hash
        request = PaymentRequest.new req
      elsif req.kind_of? PaymentRequest
        request = req
      else
        raise ArgumentException, 'You must pass a Hash or PaymentRequest to this method.'
      end
      
      request.perform
    end
  end
end 