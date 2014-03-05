require 'multi_json'

require 'dotenv'
Dotenv.load

require "automatic/client/version"
require "automatic/client/request"
require "automatic/client/error"

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
  end
end
