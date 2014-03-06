require 'multi_json'

require 'dotenv'
Dotenv.load

require "automatic/client/version"

require "automatic/routes"
require "automatic/route"

require "automatic/client/request"
require "automatic/client/error"

require "automatic/client/response"

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
      routes = Automatic::Routes.new
      routes.add_route(Automatic::Route.new('trips', 'https://api.automatic.com/v1/trips'))
      routes.add_route(Automatic::Route.new('trips', 'https://api.automatic.com/v1/trips/{id}', templated: true))
      routes.add_route(Automatic::Route.new('vehicles', 'https://api.automatic.com/v1/vehicles'))
      routes.add_route(Automatic::Route.new('vehicle', 'https://api.automatic.com/v1/vehicle/{id}', templated: true))
      routes
    end
  end
end
