require 'faraday_middleware'

module Automatic
  module Client
    class Request
      MissingApiHostError     = Class.new(StandardError)
      MissingAccessTokenError = Class.new(StandardError)

      # Make a get request with options. Automatic currently
      # doesn't support writing, so this will only retrieve records.
      #
      # @example
      #   request = Automatic::Client::Request.get('/v1/trips', per_page: 10)
      #
      # This will delegate to Faraday.
      #
      # @return [Faraday::Response] The full Response body
      def self.get(uri, options={})
        connection = Faraday.new(self.api_host) do |c|
          c.use(FaradayMiddleware::FollowRedirects)
          c.adapter(Faraday.default_adapter) # NOTE: Use Typhoeus
        end

        connection.headers['User-Agent']    = 'Automatic API Client'
        connection.headers['Authorization'] = "bearer %s" % [self.access_token]

        connection.get(uri, options)
      end

      # This retrieves the value of the API host variable.
      #
      # @raise [MissingApiHostError] If the key can't be found
      #
      # @return [String] The API Host
      def self.api_host
        begin
          ENV.fetch('API_HOST')
        rescue
          raise MissingApiHostError.new('Please provide the API_HOST env variable')
        end
      end

      # This retrieves the value of the Access Token variable.
      #
      # @raise [MissingAccessTokenError] If the key can't be found
      #
      # @return [String] The Access Token
      def self.access_token
        begin
          ENV.fetch('ACCESS_TOKEN')
        rescue
          raise MissingAccessTokenError.new('Please provide the ACCESS_TOKEN env variable')
        end
      end
    end
  end
end
