module Pigeon
  class PaymentRequest < TransactionRegistrationRequest
    def initialize(data = {})
      super()
      @postdata.merge!({
        'TxType' => 'PAYMENT'
      }).merge!(data)
      
      if @postdata[:amount]
        @postdata['Amount'] = "%.2f" % ((@postdata[:amount].to_f)/100.0)
        @postdata.delete :amount
      end
      if @postdata[:card_type]
        @postdata['CardType'] = self.class.card_type_from_sym(@postdata[:card_type])
        @postdata.delete :card_type
      end
    end
    
    def perform
      PaymentResponse.new(perform_post @url, @postdata)
    end
  end
end