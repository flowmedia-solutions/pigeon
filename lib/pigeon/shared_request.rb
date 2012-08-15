module Pigeon
  class SharedRequest < Request
    def initialize
      super
      @postdata.merge!({
        'VPSProtocol' => Pigeon.config[:vps_protocol],
        'Vendor' => Pigeon.config[:vendor]
      })
    end
  end
end