require 'httparty'

module Pinboard
  class Request
    include HTTParty

    def initialize(username, password)
      self.class.basic_auth username, password
    end

    def req
      @params ||= { }
      @params.merge({ :format => 'json' })

      path = @calls.join('/')
      @calls = []

      response = self.class.get("https://api.pinboard.in/v1/#{path}", :query => @params)
      parsed_response = response.parsed_response

      if parsed_response.kind_of?(String) && parsed_response.index('401 Forbidden')
        raise InvalidCredentialsError
      end

      parsed_response
    end

    def clear
      @calls = []
      return
    end

    private
    def method_missing(name, *args, &block)
      @calls ||= []

      return self if name == :clear || name == :req

      if name != :params
        @calls.push(name)
      else
        @params = args[0]
      end

      self
    end
  end
end