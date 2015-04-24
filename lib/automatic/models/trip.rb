module Automatic
  module Models
    class Trip
      include Comparable

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

      # Implement Comparable for extended Enumerable support
      #
      # @return [Array]
      def <=>(other)
        self.start_at <=> other.start_at
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
      alias :ended_at :end_at

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
      alias :started_at :start_at

      # Returns the timezone of the start destination
      #
      # @return [String]
      def start_time_zone
        @attributes.fetch('start_timezone', nil)
      end

      # Return the elapsed time of the Trip in seconds
      #
      # @todo Take down to seconds and support (seconds, minutes, hours)
      # @todo Create a helper extension that will be smart and know seconds and minutes
      #
      # @return [Float] Elapsed time of the trip
      def duration
        @attributes.fetch('duration_s', 0).to_f
      end
      alias :elapsed_time :duration
      alias :seconds_driven :duration

      # Returns the total minutes driven
      #
      # @note This is temporary until a conversion object is built
      #
      # @return [Float]
      def minutes_duration
        (self.duration / 60).to_f
      end

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
        @attributes.fetch('duration_over_80_s', 0).to_i
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
        @attributes.fetch('duration_over_75_s', 0).to_i
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
        @attributes.fetch('duration_over_70_s', 0).to_i
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
      alias :idling_time :idling_time_s

      # Returns the total time spent driving. This is the
      # total duration minus the amount of idling time.
      #
      # @return [Float]
      def driving_time
        (self.duration - self.idling_time)
      end

      # Returns the average time of this trip that
      # was spend in motion.
      #
      # @return [Float]
      def average_driving_time
        ((self.driving_time / self.duration) * 100)
      end

      # Returns the average time of this trip that
      # was spend idling.
      #
      # @return [Float]
      def average_idling_time
        ((self.idling_time / self.duration) * 100)
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

      # Returns a Tags instance from the trip tags. This is
      # a cross section of this Trip and a core Tag model.
      #
      # @note This is subject to change as it would be
      # better if it returned a collection of objects
      # instead of an array.
      #
      # @return [Automatic::Models::Taggings]
      def tags
        return @tags if @tags

        tag_names = @attributes.fetch('tags', [])

        tag_collection = tag_names.map do |label|
          {
            'tag' => label
          }
        end

        @tags = Automatic::Models::Taggings.new(tag_collection)
        @tags
      end

      # Returns true if there are any tags for the trip
      #
      # @return [Boolean]
      def tags?
        self.tags.any?
      end

      # Helper method to determine if this trip was tagged
      # as business
      #
      # @return [Boolean]
      def business?
        self.tags? && self.tags.business?
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
