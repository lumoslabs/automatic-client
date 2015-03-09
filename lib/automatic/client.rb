require 'multi_json'

require 'restless_router'

require 'dotenv'
Dotenv.load

require 'automatic/core'

require "automatic/client/version"

require "automatic/client/request"
require "automatic/client/error"

require "automatic/client/response"


require "automatic/client/polyline"

require "automatic/client/trips"
require "automatic/client/trip"

require "automatic/client/vehicles"
require "automatic/client/vehicle"

require "automatic/client/users"
require "automatic/client/user"

require "automatic/client/user_metadata"

require "automatic/client/locations"
require "automatic/client/location"

require "automatic/client/address"

require "automatic/core_extension"

require "automatic/utilities"

module Automatic
  module Client
    def self.scopes
      return @scopes if @scopes

      scope_definitions_file = File.expand_path('../../../data/scopes.json', __FILE__)
      scope_definitions      = MultiJson.load(File.read(scope_definitions_file))

      @scopes = Automatic::Core::Scopes.new(scope_definitions)
      @scopes
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
