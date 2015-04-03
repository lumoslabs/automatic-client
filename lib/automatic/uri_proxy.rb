require 'uri'
require 'delegate'

module Automatic
  class UriProxy < SimpleDelegator
    # Create a new UriProxy model
    #
    # @paran url [String]
    #
    # @return [Automatic::UriProxy] Delegatory to Ruby URI
    def initialize(url)
      @_url = URI(url)
    end

    # Helper method to take the URI and perform a GET
    #
    # @param data [Hash] The HTTP Query String or Body Data
    # @param headers [Hash] The HTTP Headers to send
    #
    # @return [Automatic::Response] Faraday Response Delegator
    def get(data={}, headers={})
      Automatic::Client.get(self.to_s, data, headers)
    end

    # Helper method to take the URI and perform a HEAD
    #
    # @param data [Hash] The HTTP Query String or Body Data
    # @param headers [Hash] The HTTP Headers to send
    #
    # @return [Automatic::Response] Faraday Response Delegator
    def head(data={}, headers={})
      Automatic::Client.head(self.to_s, data, headers)
    end

    # Helper method to take the URI and perform an OPTIONS
    #
    # @param headers [Hash] The HTTP Headers to send
    #
    # @return [Automatic::Response] Faraday Response Delegator
    def options(headers={})
      Automatic::Client.options(self.to_s, headers)
    end

    # Helper method to take the URI and perform a PUT
    #
    # @param data [Hash] The HTTP Query String or Body Data
    # @param headers [Hash] The HTTP Headers to send
    #
    # @return [Automatic::Response] Faraday Response Delegator
    def put(data={}, headers={})
      Automatic::Client.put(self.to_s, data, headers)
    end

    # Helper method to take the URI and perform a PATCH
    #
    # @param data [Hash] The HTTP Query String or Body Data
    # @param headers [Hash] The HTTP Headers to send
    #
    # @return [Automatic::Response] Faraday Response Delegator
    def patch(data={}, headers={})
      Automatic::Client.patch(self.to_s, data, headers)
    end

    # Helper method to take the URI and perform a POST
    #
    # @param data [Hash] The HTTP Query String or Body Data
    # @param headers [Hash] The HTTP Headers to send
    #
    # @return [Automatic::Response] Faraday Response Delegator
    def post(data={}, headers={})
      Automatic::Client.post(self.to_s, data, headers)
    end

    # Helper method to take the URI and perform a DELETE
    #
    # @param data [Hash] The HTTP Query String or Body Data
    # @param headers [Hash] The HTTP Headers to send
    #
    # @return [Automatic::Response] Faraday Response Delegator
    def delete(data={}, headers={})
      Automatic::Client.delete(self.to_s, data, headers)
    end

    # Return the delegated object
    #
    # @return [URI]
    def __getobj__
      @_url
    end
  end
end
