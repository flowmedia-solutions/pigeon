require 'httparty'

module Pigeon
  class Request
    include ::HTTParty
    
    def initialize
      @postdata = {}
    end
    
    def perform_post
      self.class.post @url, query: @postdata
    end
    
    def perform
      Response.new perform_post
    end
    
    def valid?
      true
    end
  end
end