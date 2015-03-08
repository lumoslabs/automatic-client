require 'multi_json'

require 'restless_router'

require 'dotenv'
Dotenv.load

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

require "automatic/core_extension"

module Automatic
  module Client
    def self.scopes
      %w( scope:location scope:vehicle scope:trip_summary scope:ignition:on scope:ignition:off scope:notification:speeding scope:notification:hard_brake scope:notification:hard_accel scope:region:changed scope:parking:changed scope:mil:on scope:mil:off )
    end

    def self.routes
      routes = RestlessRouter::Routes.new
      routes.add_route(RestlessRouter::Route.new('trips', 'https://api.automatic.com/trip/{?page,per_page}', templated: true))
      routes.add_route(RestlessRouter::Route.new('trip', 'https://api.automatic.com/trip/{id}', templated: true))
      routes.add_route(RestlessRouter::Route.new('vehicles', 'https://api.automatic.com/vehicle/{?page,per_page}', templated: true))
      routes.add_route(RestlessRouter::Route.new('vehicle', 'https://api.automatic.com/vehicle/{id}', templated: true))
      routes
    end
  end
end
