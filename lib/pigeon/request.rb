require 'httparty'

module Pigeon
  class Request
    include ::HTTParty
    
    def initialize
      @postdata = {}
    end
    
    def perform_post(url, data)
      self.class.post url, body: data
    end
    
    def perform
      Response.new(perform_post @url, @postdata)
    end
    
    def valid?
      true
    end
  end
end