require 'httparty'

class Pinboard
  include HTTParty

  def initialize(username, password)
    self.class.basic_auth username, password
  end

  def req
    @params ||= {}
    @params.merge({:format => 'json'})

    path = @calls.join('/')
    @calls = []

    self.class.get("https://api.pinboard.in/v1/#{path}", :query => @params).inspect
  end


  private
  def method_missing(name, *args, &block)
    @calls ||= []

    if name != :params
      @calls.push(name)
    else
      @params = args[0]
    end

    self
  end
end
