module Automatic
  module Utilities
    module ConnectionWrapper
      # Helper method to build the core Connection to the API
      # itself.
      #
      # @return [Automatic::Connection] A Connection delegator to Faraday
      def connection
        @connection ||= Automatic::Connection.new(url: configuration.api_host) do |builder|
          builder.request(:json)
          builder.response(:json, content_type: /\bjson$/)
          builder.response(:logger, configuration.request_logger) if configuration.request_logger
          builder.use(FaradayMiddleware::FollowRedirects, limit: 3)
          builder.use(Automatic::Middleware::Gzip)
          builder.adapter(Automatic::Connection.default_adapter)
        end

        # Inject Authorization
        @connection.headers['Authorization'] = ("Bearer %s" % [access_token])

        # Inject default headers
        @connection.headers.merge!(configuration.connection_options[:headers])

        @connection
      end

      # Helper method to peform a GET request
      #
      # @return [Automatic::Response] Faraday Response Delegator
      def get(url, data={}, headers={})
        request = connection.get(url, data, headers)

        Automatic::Response.new(request)
      end

      # Helper method to perform a HEAD request
      #
      # @return [Automatic::Response] Faraday Response Delegator
      def head(url, data={}, headers={})
        request = connection.head(url, data, headers)

        Automatic::Response.new(request)
      end

      # Helper method to perform a OPTIONS request
      #
      # @return [Automatic::Response] Faraday Response Delegator
      def options(url, headers={})
        request = connection.http_options(url, nil, headers)

        Automatic::Response.new(request)
      end

      # Helper method to perform a PUT request
      #
      # @return [Automatic::Response] Faraday Response Delegator
      def put(url, data={}, headers={})
        request = connection.put(url, data, headers)

        Automatic::Response.new(request)
      end

      # Helper method to perform a PATCH request
      #
      # @return [Automatic::Response] Faraday Response Delegator
      def patch(url, data={}, headers={})
        request = connection.patch(url, data, headers)

        Automatic::Response.new(request)
      end

      # Helper method to perform a POST request
      #
      # @return [Automatic::Response] Faraday Response Delegator
      def post(url, data={}, headers={})
        request = connection.post(url, data, headers)

        Automatic::Response.new(request)
      end

      # Helper method to perform a DELETE request
      #
      # @return [Automatic::Response] Faraday Response Delegator
      def delete(url, data={}, headers={})
        request = connection.delete(url, data, headers)

        Automatic::Response.new(request)
      end
    end
  end
end
