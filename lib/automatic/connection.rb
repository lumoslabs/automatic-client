require 'faraday_middleware'
require 'delegate'

module Automatic
  class Connection < SimpleDelegator

    # Create a delegator to Faraday
    #
    # @param url [String] URL to make the request against
    #
    # @return [Automatic::Connection] Faraday delegator
    def initialize(url, &block)
      @_connection = Faraday.new(url, &block)
    end

    # Return the Net::HTTP default adapter from Faraday
    #
    # @return [Symbol] Default adapter
    def self.default_adapter
      Faraday.default_adapter
    end

    # Faraday does not provide an HTTP OPTIONS call. Its
    # core library utilizes `options` for RequestOptions.
    #
    # This allows us to perform an HTTP options request
    #
    # @param url [String] The URL to make the request to
    # @param params [Hash] Request parameters to send
    # @param headers [Hash] Request headers to send
    #
    # @return [Faraday::Response] Faraday Response
    def http_options(url=nil, params=nil, headers=nil)
      @_connection.run_request(:options, url, params, headers)
    end

    # Return the object for the delegation
    #
    # @return [Faraday] Faraday
    def __getobj__
      @_connection
    end
  end
end
