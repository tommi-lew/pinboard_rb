 require 'pinboard/request'
 require 'pinboard/exceptions'

 module Pinboard
  def self.new(username, password)
    Pinboard::Request.new(username, password)
  end
end
