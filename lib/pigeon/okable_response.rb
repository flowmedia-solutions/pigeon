module Pigeon
  class OkableResponse < Response
    def success?
      super && to_hash['Status'] == 'OK'
    end
  end
end