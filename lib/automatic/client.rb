require 'logger'
require 'multi_json'
require 'faraday'

require 'restless_router'

require 'dotenv'
Dotenv.load

require "automatic/client/version"
require "automatic/middleware"
require "automatic/core_extension"
require "automatic/utilities"
require 'automatic/uri_proxy'
require 'automatic/core'
require 'automatic/configuration'
require 'automatic/connection'
require 'automatic/response'
require 'automatic/models'

module Automatic
  module Client
    class << self
      attr_accessor :configuration
      attr_accessor :scopes
      attr_accessor :webhooks
      attr_accessor :errors
      attr_accessor :routes
    end

    # Configuration details for them and interacting
    # with the Automatic API.
    #
    # @return [Automatic::Configuration] Configuration with defaults applied
    def self.configuration
      @configuration ||= Automatic::Configuration.new
    end

module Automatic
  module Client
    class << self
      attr_accessor :configuration
      attr_accessor :scopes
      attr_accessor :webhooks
      attr_accessor :errors
      attr_accessor :routes
    end

    # Configuration details for them and interacting
    # with the Automatic API.
    #
    # @return [Automatic::Configuration] Configuration with defaults applied
    def self.configuration
      @configuration ||= Automatic::Configuration.new
    end

    # Modify the configuration details via a `block`
    #
    # @return [Automatic::Configuration]
    def self.configure
      yield(self.configuration)
    end

    # Helper method to build the core Connection to the API
    # itself.
    #
    # @return [Automatic::Connection] A Connection delegator to Faraday
    def self.connection
      @connection ||= Automatic::Connection.new(url: self.configuration.api_host) do |builder|
        builder.request(:json)
        builder.response(:json, content_type: /\bjson$/)
        builder.response(:logger, self.configuration.request_logger) if self.configuration.request_logger
        builder.use(FaradayMiddleware::FollowRedirects, limit: 3)
        builder.use(Automatic::Middleware::Gzip)
        builder.adapter(Automatic::Connection.default_adapter)
      end

      # Inject Authorization
      @connection.headers['Authorization'] = ("Bearer %s" % [self.configuration.access_token])

      # Inject default headers
      @connection.headers.merge!(self.configuration.connection_options[:headers])

      @connection
    end

    # Helper method to peform a GET request
    #
    # @return [Automatic::Response] Faraday Response Delegator
    def self.get(url, data={}, headers={})
      request = self.connection.get(url, data, headers)

      Automatic::Response.new(request)
    end

    # Helper method to perform a HEAD request
    #
    # @return [Automatic::Response] Faraday Response Delegator
    def self.head(url, data={}, headers={})
      request = self.connection.head(url, data, headers)

      Automatic::Response.new(request)
    end

    # Helper method to perform a OPTIONS request
    #
    # @return [Automatic::Response] Faraday Response Delegator
    def self.options(url, headers={})
      request = self.connection.http_options(url, nil, headers)

      Automatic::Response.new(request)
    end

    # Helper method to perform a PUT request
    #
    # @return [Automatic::Response] Faraday Response Delegator
    def self.put(url, data={}, headers={})
      request = self.connection.put(url, data, headers)

      Automatic::Response.new(request)
    end

    # Helper method to perform a PATCH request
    #
    # @return [Automatic::Response] Faraday Response Delegator
    def self.patch(url, data={}, headers={})
      request = self.connection.patch(url, data, headers)

      Automatic::Response.new(request)
    end

    # Helper method to perform a POST request
    #
    # @return [Automatic::Response] Faraday Response Delegator
    def self.post(url, data={}, headers={})
      request = self.connection.post(url, data, headers)

      Automatic::Response.new(request)
    end

    # Helper method to perform a DELETE request
    #
    # @return [Automatic::Response] Faraday Response Delegator
    def self.delete(url, data={}, headers={})
      request = self.connection.delete(url, data, headers)

      Automatic::Response.new(request)
    end

    def self.scopes
      return @scopes if @scopes

      scope_definitions_file = File.expand_path('../../../data/scopes.json', __FILE__)
      scope_definitions      = MultiJson.load(File.read(scope_definitions_file))

      @scopes = Automatic::Core::Scopes.new(scope_definitions)
      @scopes
    end

    def self.webhooks
      return @webhooks if @webhooks

      webhook_definitions_file = File.expand_path('../../../data/webhooks.json', __FILE__)
      webhook_definitions      = MultiJson.load(File.read(webhook_definitions_file))

      @webhooks = Automatic::Core::Webhooks.new(webhook_definitions)
      @webhooks
    end

    def self.errors
      return @errors if @errors

      error_definitions_file = File.expand_path('../../../data/errors.json', __FILE__)
      error_definitions      = MultiJson.load(File.read(error_definitions_file))

      @errors = Automatic::Core::Errors.new(error_definitions)
      @errors
    end

    def self.routes
      return @routes if @routes

      route_definitions_file = File.expand_path('../../../data/routes.json', __FILE__)
      route_definitions      = MultiJson.load(File.read(route_definitions_file))

      @routes = RestlessRouter::Routes.new

      route_definitions.each do |definition|
        @routes.add_route(RestlessRouter::Route.new(definition['rel'], definition['path'], templated: definition['templated']))
      end

      @routes
    end
  end
end
