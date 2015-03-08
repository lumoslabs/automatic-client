require 'multi_json'

require 'restless_router'

require 'dotenv'
Dotenv.load

require 'automatic/scopes'
require 'automatic/scope'

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

      @scopes = Automatic::Scopes.new(scope_definitions)

      @scopes
    end

    def self.routes
      return @routes if @routes

      @routes = RestlessRouter::Routes.new
      @routes.add_route(RestlessRouter::Route.new('trips', 'https://api.automatic.com/trip/{?page,per_page}', templated: true))
      @routes.add_route(RestlessRouter::Route.new('trip', 'https://api.automatic.com/trip/{id}', templated: true))
      @routes.add_route(RestlessRouter::Route.new('vehicles', 'https://api.automatic.com/vehicle/{?page,per_page}', templated: true))
      @routes.add_route(RestlessRouter::Route.new('vehicle', 'https://api.automatic.com/vehicle/{id}', templated: true))
      @routes.add_route(RestlessRouter::Route.new('user', 'https://api.automatic.com/user/{id}', templated: true))
      @routes.add_route(RestlessRouter::Route.new('user-profile', 'https://api.automatic.com/user/{id}/profile/', templated: true))
      @routes.add_route(RestlessRouter::Route.new('user-metadata', 'https://api.automatic.com/user/{id}/metadata/', templated: true))
      @routes.add_route(RestlessRouter::Route.new('user-trips', 'https://api.automatic.com/user/{id}/trip/', templated: true))
      @routes.add_route(RestlessRouter::Route.new('user-vehicles', 'https://api.automatic.com/user/{id}/vehicle/', templated: true))

      @routes
    end
  end
end
