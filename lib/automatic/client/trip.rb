module Automatic
  module Client
    class Trip
      def initialize(attributes={})
        @attributes = attributes
      end

      def id
        @attributes.fetch('id', nil)
      end

      def url
        @attributes.fetch('url', nil)
      end

      def vehicle
        @attributes.fetch('vehicle', nil)
      end

      def user
        @attributes.fetch('user', nil)
      end

      def end_location
        @end_location ||= Automatic::Client::Location.new(end_location_params)
      end

      def end_address
        @end_address ||= Automatic::Client::Address.new(end_address_params)
      end

      def end_at
        end_time_before_zone.extend(Automatic::CoreExtension::Time).in_zone(self.end_time_zone)
      end

      def end_time_zone
        @attributes.fetch('end_timezone', nil)
      end

      def start_location
        @start_location ||= Automatic::Client::Location.new(start_location_params)
      end

      def start_address
        @start_address ||= Automatic::Client::Address.new(start_address_params)
      end

      def start_at
        start_time_before_zone.extend(Automatic::CoreExtension::Time).in_zone(self.start_time_zone)
      end

      def start_time_zone
        @attributes.fetch('start_timezone', nil)
      end

      # Return the elapsed time of the Trip in minutes
      #
      # TODO: Take down to seconds and support (seconds, minutes, hours)
      # TODO: Create a helper extension that will be smart and know seconds and minutes
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
      # @return [Polyline] The Polyline object
      def polyline
        @polyline ||= Automatic::Client::Polyline.new(self.path)
      end

      def distance_in_miles
        (distance_m.to_i * 0.000621371)
      end

      def distance_m
        @attributes.fetch('distance_m', nil)
      end
      alias :distance_in_meters :distance_m

      def hard_accels
        @attributes.fetch('hard_accels', 0)
      end

      def hard_brakes
        @attributes.fetch('hard_brakes', 0)
      end

      def duration_over_80_s
        @attributes.fetch('duration_over_80_s', 0)
      end
      alias :duration_over_80 :duration_over_80_s

      def duration_over_75_s
        @attributes.fetch('duration_over_75_s', 0)
      end
      alias :duration_over_75 :duration_over_75_s

      def duration_over_70_s
        @attributes.fetch('duration_over_70_s', 0)
      end
      alias :duration_over_70 :duration_over_70_s

      def score
        @attributes.fetch('score', 0).to_i
      end

      def fuel_cost_usd
        @attributes.fetch('fuel_cost_usd', 0)
      end
      alias :fuel_cost :fuel_cost_usd

      def fuel_volume_l
        @attributes.fetch('fuel_volume_l', 0).to_f
      end

      def fuel_volume_gal
        (self.fuel_volume_l * 0.264172).to_f
      end
      alias :fuel_volume :fuel_volume_gal

      def average_kmpl
        @attributes.fetch('average_kmpl', 0).to_f
      end

      def average_mpg
        val = self.average_kmpl
        val = (val * 2.35214583)
        ("%.1f" % [val]).to_f
      end

      # TODO: Return a Polymorphic Events Object
      def events
        @attributes.fetch('vehicle_events', [])
      end

      def events?
        self.events.any?
      end

      private
      def vehicle_params
        @attributes.fetch('vehicle', {})
      end

      def user_params
        @attributes.fetch('user', {})
      end

      def start_address_params
        @attributes.fetch('start_address', {})
      end

      def end_address_params
        @attributes.fetch('end_addres', {})
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
