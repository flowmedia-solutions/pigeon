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
    
    def self.threeds_validation(req)
      if req.is_a? Hash
        request = ThreedsValidationRequest.new req
      elsif req.kind_of? ThreedsValidationRequest
        request = req
      else
        raise ArgumentException, 'You must pass a Hash or ThreedsValidationRequest to this method.'
      end
      
      request.perform
    end
    
    def self.void_request(req)
      if req.is_a? Hash
        request = VoidRequest.new req
      elsif req.kind_of? PaymentRequest
        request = req
      else
        raise ArgumentException, 'You must pass a Hash or PaymentRequest to this method.'
      end
      
      request.perform
    end
    
    def self.refund_request(req)
      if req.is_a? Hash
        request = RefundRequest.new req
      elsif req.kind_of? PaymentRequest
        request = req
      else
        raise ArgumentException, 'You must pass a Hash or PaymentRequest to this method.'
      end
      
      request.perform
    end
  end
end 