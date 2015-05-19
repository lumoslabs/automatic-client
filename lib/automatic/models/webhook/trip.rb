require File.expand_path('../../polyline', __FILE__)
require File.expand_path('../location', __FILE__)

module Automatic
  module Models
    module Webhook
      class Trip
        # Build an instance of the Webhook Trip model.
        #
        # @note This is here to support the webhook trip model. The
        # core Trip model has diverged.
        #
        # @param attributes [Hash]
        #
        # @return [Automatic::Models::Webhook::Trip]
        def initialize(attributes={})
          @attributes = attributes
        end

        # Return the ID of the Trip
        #
        # @return [String]
        def id
          @attributes['id']
        end

        # It returns the path polyline
        #
        # @return [String]
        def path
          @attributes['path']
        end

        # Return an instance of the Webhook Location
        # for the start location
        #
        # @return [Automatic::Models::Webhook::Location]
        def start_location
          Automatic::Models::Webhook::Location.new(@attributes.fetch('start_location', {}))
        end

        # Return an instance of the Webhook Location
        # for the end location
        #
        # @return [Automatic::Models::Webhook::Location]
        def end_location
          Automatic::Models::Webhook::Location.new(@attributes.fetch('end_location', {}))
        end

        # Return the distance in meters
        #
        # @return [Float]
        def distance_m
          @attributes['distance_m'].to_f
        end
        alias :distance_in_meters :distance_m

        # Returns the distance in miles
        #
        # @todo wrap with a distance conversion utility
        #
        # @return [Float]
        def distance_in_miles
          (self.distance_m.to_i * 0.000621371)
        end

        # Returns the fuel cost in US Dollars
        #
        # @return [Integer]
        def fuel_cost_usd
          @attributes.fetch('fuel_cost_usd', 0)
        end
        alias :fuel_cost :fuel_cost_usd

        # Returns the fuel volume in gallons
        #
        # @return [Float]
        def fuel_volume_gal
          @attributes['fuel_volume_gal'].to_f
        end
        alias :fuel_volume :fuel_volume_gal

        # Returns the average MPG
        #
        # @return [Float]
        def average_mpg
          @attributes['average_mpg'].to_f
        end

        # Returns the counter cache of HardAccel events. This
        # should match up to VehicleEvents counts.
        #
        # @todo Change this to `hard_accels_count`, as we would want
        # this to possibly represent all VehicleEvents with a `hard_accel`
        # type.
        #
        # @return [Integer]
        def hard_accels
          @attributes.fetch('hard_accels', 0).to_i
        end
        alias :hard_accels_count :hard_accels

        # Returns true if there are hard accels
        #
        # @return [Boolean]
        def hard_accels?
          self.hard_accels > 0
        end

        # Returns the counter cache of HardBrake events. This
        # should match up to VehicleEvents counts.
        #
        # @todo Change this to `hard_brakes_count`, as we would want
        # this to possibly represent all VehicleEvents with a `hard_brake`
        # type.
        #
        # @return [Integer]
        def hard_brakes
          @attributes.fetch('hard_brakes', 0).to_i
        end
        alias :hard_brakes_count :hard_brakes

        # Returns true if there are hard brakes
        #
        # @return [Boolean]
        def hard_brakes?
          self.hard_brakes > 0
        end

        # Return the duration of the trip over 80 in seconds
        #
        # @todo Capture the VehicleEvents that are `speeding` and
        # return the objects.
        #
        # @return [Integer]
        def duration_over_80_s
          @attributes.fetch('duration_over80_s', 0).to_i
        end
        alias :duration_over_80 :duration_over_80_s

        # Return true if there is any duration (seconds) over 80
        #
        # @note Temporary until we have a conversion object
        #
        # @return [Boolean]
        def duration_over_80?
          self.duration_over_80 > 0
        end

        # Return the duration of the trip over 80 in minutes
        #
        # @note This will be moved to a conversion object
        #
        # @return [Integer]
        def minutes_over_80
          (self.duration_over_80 / 60).ceil
        end

        # Returns true if there is any duration (minutes) over 80
        #
        # @return [Integer]
        def minutes_over_80?
          self.minutes_over_80 > 0
        end

        # Return the duration of the trip over 75 in seconds
        #
        # @todo Capture the VehicleEvents that are `speeding` and
        # return the objects.
        #
        # @return [Integer]
        def duration_over_75_s
          @attributes.fetch('duration_over75_s', 0).to_i
        end
        alias :duration_over_75 :duration_over_75_s

        # Return true if there is any duration (seconds) over 75
        #
        # @note Temporary until we have a conversion object
        #
        # @return [Boolean]
        def duration_over_75?
          self.duration_over_75 > 0
        end

        # Return the duration of the trip over 75 in minutes
        #
        # @note This will be moved to a conversion object
        #
        # @return [Integer]
        def minutes_over_75
          (self.duration_over_75 / 60).to_i
        end

        # Returns true if there is any duration (minutes) over 75
        #
        # @return [Integer]
        def minutes_over_75?
          self.minutes_over_75 > 0
        end

        # Return the duration of the trip over 70 in seconds
        #
        # @todo Capture the VehicleEvents that are `speeding` and
        # return the objects.
        #
        # @return [Integer]
        def duration_over_70_s
          @attributes.fetch('duration_over70_s', 0).to_i
        end
        alias :duration_over_70 :duration_over_70_s

        # Return true if there is any duration (seconds) over 70
        #
        # @note Temporary until we have a conversion object
        #
        # @return [Boolean]
        def duration_over_70?
          self.duration_over_70 > 0
        end

        # Return the duration of the trip over 70 in minutes
        #
        # @note This will be moved to a conversion object
        #
        # @return [Integer]
        def minutes_over_70
          (self.duration_over_70 / 60).to_i
        end

        # Returns true if there is any duration (minutes) over 70
        #
        # @return [Integer]
        def minutes_over_70?
          self.minutes_over_70 > 0
        end

        # This returns an association to the Polyline proxy that
        # can encode and decode the details.
        #
        # @return [Automatic::Models::Polyline] The Polyline object
        def polyline
          @polyline ||= Automatic::Models::Polyline.new(self.path)
        end

        # Return the start timezone of the trip
        #
        # @return [String]
        def start_time_zone
          @attributes['start_time_zone']
        end
        alias :start_timezone :start_time_zone

        # Return the UNIX timestamp in millseconds for the start time
        #
        # @return [Integer] UNIX timestamp milliseconds
        def start_time
          @attributes['start_time'].to_i
        end

        # Return the Time of the start at of the trip
        #
        # @return [ActiveSupport::TimeWithZone]
        def start_at
          start_at_before_zone.in_time_zone(self.start_time_zone)
        end

        # Return the UNIX timestamp for the start time
        #
        # @return [Integer] UNIX timestamp
        def unix_start_time
          (self.start_time / 1000)
        end

        private
        def start_at_before_zone
          begin
            Time.at(self.unix_start_time)
          rescue
            nil
          end
        end
      end
    end
  end
end
