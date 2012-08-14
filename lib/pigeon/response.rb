module Pigeon
  class Response
    attr_reader :plain, :to_hash, :success
    def initialize(resp)
      @underlying = resp
      @plain = @underlying.nil? ? '' : @underlying.body
    end
    
    def success?
      @underlying.code == 200
    end
    
    def to_hash
      Hash[@plain.lines.map {|line| line.strip.split '=', 2 }]
    end
  end
end