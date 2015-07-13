require 'automatic/api_client/trips'
require 'automatic/api_client/vehicles'

module Automatic
  class ApiClient
    include Utilities::ConnectionWrapper

    attr_reader :access_token

    def initialize(access_token)
      @access_token = access_token
    end

    private

    def configuration
      Automatic::Client.configuration
    end
  end
end
