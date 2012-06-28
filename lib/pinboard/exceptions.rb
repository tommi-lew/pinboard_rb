module Pinboard
  class InvalidCredentialsError < StandardError; end
  class TooManyRequestsError < StandardError; end
  class UnableToRenderURIError < StandardError; end
end
