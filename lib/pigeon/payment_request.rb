module Pigeon
  class PaymentRequest < TransactionRegistrationRequest
    def initialize
      super
      @postdata.merge({
        'TxType' => 'PAYMENT'
      })
    end
  end
end