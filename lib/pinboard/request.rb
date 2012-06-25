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

      error = process_response_code(response.response.code)
      raise error if error != nil

      response.parsed_response
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

    def process_response_code(response_code)
      case response_code
        when '401'
          InvalidCredentialsError
        when '429'
          TooManyRequestsError
        else
          nil
      end
    end
  end
end
