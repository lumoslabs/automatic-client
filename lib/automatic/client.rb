require 'logger'
require 'multi_json'
require 'faraday'

require 'active_support'
require 'active_support/core_ext'

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
require 'automatic/api_client'

module Automatic
  module Client
    extend Utilities::ConnectionWrapper

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

    # Returns the configured access token
    #
    # @return [String]
    def self.access_token
      self.configuration.access_token
    end

    # Returns the defined set of scopes from Automatic
    #
    # @return [Automatic::Core::Scopes] Collection of Scope Domain Models
    def self.scopes
      return @scopes if @scopes

      scope_definitions_file = File.expand_path('../../../data/scopes.json', __FILE__)
      scope_definitions      = MultiJson.load(File.read(scope_definitions_file))

      @scopes = Automatic::Core::Scopes.new(scope_definitions)
      @scopes
    end

    # Returns the defined set of webhooks from Automatic
    #
    # @return [Automatic::Core::Webhooks] Collection of Webhook Domain Models
    def self.webhooks
      return @webhooks if @webhooks

      webhook_definitions_file = File.expand_path('../../../data/webhooks.json', __FILE__)
      webhook_definitions      = MultiJson.load(File.read(webhook_definitions_file))

      @webhooks = Automatic::Core::Webhooks.new(webhook_definitions)
      @webhooks
    end

    # Return the defined set of Error responses from Automatic
    #
    # @note These should be returned in the body, but are useful
    # if you want to map with status codes
    #
    # @return [Automatic::Core::Errors] Collection of Error Domain Models
    def self.errors
      return @errors if @errors

      error_definitions_file = File.expand_path('../../../data/errors.json', __FILE__)
      error_definitions      = MultiJson.load(File.read(error_definitions_file))

      @errors = Automatic::Core::Errors.new(error_definitions)
      @errors
    end

    # Return the defined set of Route objects from Automatic. This
    # includes all supported URI and URI Templates to access the functionality
    # of the Automatic API.
    #
    # @return [RestlessRouter::Routes] Collection of RestlessRouter Models
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
