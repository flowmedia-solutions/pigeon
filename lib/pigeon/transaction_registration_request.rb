module Pigeon
  class TransactionRegistrationRequest < Request
    def initialize
      super
      @postdata.merge({
        'VPSProtocol' => Pigeon.config[:vps_protocol],
        'Vendor' => Pigeon.config[:vendor]
      })
      @url = Pigeon.register_url
    end
  end
end