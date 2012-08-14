module Pigeon
  class PaymentResponse < Response
    def success?
      super && ['OK','3DAUTH','PPREDIRECT','AUTHENTICATED','REGISTERED'].include?(to_hash['Status'])
    end
    
    def requires_threeds?
      to_hash['Status'] == '3DAUTH'
    end
  end
end