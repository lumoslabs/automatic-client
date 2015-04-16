module Automatic
  module Models
    class Trip
      # Create an instance of the Trip domain model
      #
      # @param attributes [Hash] Automatic Trip Definition
      #
      # @return [Automatic::Models::Trip]
      def initialize(attributes={})
        @attributes = attributes
      end

      # Returns the ID of the trip record
      #
      # @return [String]
      def id
        @attributes.fetch('id', nil)
      end

      # Returns the URL of the record
      #
      # @todo return a Uri wrapped object
      #
      # @return [String]
      def url
        @attributes.fetch('url', nil)
      end

      # Returns the URL of the vehicle
      #
      # @todo return a Uri wrapped object
      # @todo ensure this is the vehicle object
      #
      # @return [String] Vehicle URL
      def vehicle
        @attributes.fetch('vehicle', nil)
      end

      # Returns the URL of the user
      #
      # @todo return a Uri wrapped object
      # @todo ensure this is the user object
      #
      # @return [String] User URL
      def user
        @attributes.fetch('user', nil)
      end

      # Returns a Location model for the end location
      #
      # @return [Automatic::Models::Location]
      def end_location
        @end_location ||= Automatic::Models::Location.new(end_location_params)
      end

      # Returns an Address model for the end address
      #
      # @return [Automatic::Models::Address]
      def end_address
        @end_address ||= Automatic::Models::Address.new(end_address_params)
      end

      # Returns the time the trip ended
      #
      # @return [DateTime]
      def end_at
        end_time_before_zone.extend(Automatic::CoreExtension::Time).in_zone(self.end_time_zone)
      end

      # Returns the timezone of the end destination
      #
      # @return [String]
      def end_time_zone
        @attributes.fetch('end_timezone', nil)
      end

      # Returns a Location model for the start location
      #
      # @return [Automatic::Models::Location]
      def start_location
        @start_location ||= Automatic::Models::Location.new(start_location_params)
      end

      # Returns an Address model for the start address
      #
      # @return [Automatic::Models::Address]
      def start_address
        @start_address ||= Automatic::Models::Address.new(start_address_params)
      end

      # Returns the time the trip started
      #
      # @return [DateTime]
      def start_at
        start_time_before_zone.extend(Automatic::CoreExtension::Time).in_zone(self.start_time_zone)
      end

      # Returns the timezone of the start destination
      #
      # @return [String]
      def start_time_zone
        @attributes.fetch('start_timezone', nil)
      end

      # Return the elapsed time of the Trip in minutes
      #
      # @todo Take down to seconds and support (seconds, minutes, hours)
      # @todo Create a helper extension that will be smart and know seconds and minutes
      #
      # @return [Float] Elapsed time of the trip
      def duration
        @attributes.fetch('duration_s', 0).to_f
      end
      alias :elapsed_time :duration

      # This returns the Endcoded Polyline path.
      #
      # @return [String] Encoded polyline
      def path
        @attributes.fetch('path', nil)
      end

      # This returns an association to the Polyline proxy that
      # can encode and decode the details.
      #
      # @return [Automatic::Models::Polyline] The Polyline object
      def polyline
        @polyline ||= Automatic::Models::Polyline.new(self.path)
      end

      # Returns the distance in miles
      #
      # @todo wrap with a distance conversion utility
      #
      # @return [Float]
      def distance_in_miles
        (self.distance_m.to_i * 0.000621371)
      end

      # Returns the distance in meters
      #
      # @return [Float]
      def distance_m
        @attributes.fetch('distance_m', nil)
      end
      alias :distance_in_meters :distance_m

      # Returns the counter cache of HardAccel events. This
      # should match up to VehicleEvents counts.
      #
      # @todo Change this to `hard_accels_count`, as we would want
      # this to possibly represent all VehicleEvents with a `hard_accel`
      # type.
      #
      # @return [Integer]
      def hard_accels
        @attributes.fetch('hard_accels', 0)
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
        @attributes.fetch('hard_brakes', 0)
      end

      # Return the duration of the trip over 80 in seconds
      #
      # @todo Capture the VehicleEvents that are `speeding` and
      # return the objects.
      #
      # @return [Integer]
      def duration_over_80_s
        @attributes.fetch('duration_over_80_s', 0)
      end
      alias :duration_over_80 :duration_over_80_s

      # Return the duration of the trip over 75 in seconds
      #
      # @todo Capture the VehicleEvents that are `speeding` and
      # return the objects.
      #
      # @return [Integer]
      def duration_over_75_s
        @attributes.fetch('duration_over_75_s', 0)
      end
      alias :duration_over_75 :duration_over_75_s

      # Return the duration of the trip over 70 in seconds
      #
      # @todo Capture the VehicleEvents that are `speeding` and
      # return the objects.
      #
      # @return [Integer]
      def duration_over_70_s
        @attributes.fetch('duration_over_70_s', 0)
      end
      alias :duration_over_70 :duration_over_70_s

      # Returns the score for event
      #
      # @return [Integer]
      def score_events
        @attributes.fetch('score_events', 0).to_i
      end

      # Returns the score for speeding
      #
      # @return [Integer]
      def score_speeding
        @attributes.fetch('score_speeding', 0).to_i
      end

      # Returns the fuel cost in US Dollars
      #
      # @return [Integer]
      def fuel_cost_usd
        @attributes.fetch('fuel_cost_usd', 0)
      end
      alias :fuel_cost :fuel_cost_usd

      # Returns the fuel volume in liters
      #
      # @return [Float]
      def fuel_volume_l
        @attributes.fetch('fuel_volume_l', 0).to_f
      end

      # Returns the fuel volume in gallons
      #
      # @return [Float]
      def fuel_volume_gal
        (self.fuel_volume_l * 0.264172).to_f
      end
      alias :fuel_volume :fuel_volume_gal

      # Returns the average kilometers per liter
      #
      # @return [Float]
      def average_kmpl
        @attributes.fetch('average_kmpl', 0).to_f
      end

      # Returns the average miles per gallon
      #
      # @return [Float]
      def average_mpg
        val = self.average_kmpl
        val = (val * 2.35214583)
        ("%.1f" % [val]).to_f
      end

      # Returns the amount of time the vehicle was idling
      # in seconds.
      #
      # @return [Integer] Seconds of idle time
      def idling_time_s
        @attributes.fetch('idling_time_s', 0).to_i
      end

      # Returns a VehicleEvents instance that captures
      # all events recorded for a trip.
      #
      # This is a polymorphic object that you can interate
      # through and work with the specific `type`
      #
      # @return [Automatic::Models::VehicleEvents]
      def events
        @events ||= Automatic::Models::VehicleEvents.new(@attributes.fetch('vehicle_events', []))
      end

      # Returns true if there were any events for the trip
      #
      # @return [Boolean]
      def events?
        self.events.any?
      end

      private
      def start_address_params
        params = @attributes['start_address']
        if params.nil? then {} else params end
      end

      def end_address_params
        params = @attributes['end_address']
        if params.nil? then {} else params end
      end

      def start_location_params
        @attributes.fetch('start_location', {})
      end

      def end_location_params
        @attributes.fetch('end_location', {})
      end

      def start_time_before_zone
        begin
          Time.parse(@attributes.fetch('started_at'))
        rescue
          nil
        end
      end

      def end_time_before_zone
        begin
          Time.parse(@attributes.fetch('ended_at'))
        rescue
          nil
        end
      end
    end
  end
end
