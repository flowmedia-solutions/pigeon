module Pigeon
  class TransactionRegistrationRequest < Request
    def initialize
      super
      @postdata.merge!({
        'VPSProtocol' => Pigeon.config[:vps_protocol],
        'Vendor' => Pigeon.config[:vendor]
      })
      @url = Pigeon.register_url
    end
    
    def self.card_type_from_sym(sym)
      map = {
        :visa => 'VISA',
        :mastercard => 'MC',
        :delta => 'DELTA',
        :maestro => 'MAESTRO',
        :uk_electron => 'UKE',
        :amex => 'AMEX',
        :diners_club => 'DC',
        :jcb => 'JCB',
        :laser => 'LASER',
        :paypal => 'PAYPAL'
      }
      map[sym]
    end
  end
end