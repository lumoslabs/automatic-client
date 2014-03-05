module Automatic
  module Client
    class Trip
      def initialize(attributes={})
        @attributes = attributes
      end

      def id
        @attributes.fetch('id', nil)
      end

      def uri
        @attributes.fetch('uri', nil)
      end

      def vehicle
        @vehicle ||= Automatic::Client::Vehicle.new(vehicle_params)
      end

      def user
        @user ||= Automatic::Client::User.new(user_params)
      end

      def end_location
        @end_location ||= Automatic::Client::Location.new(end_location_params)
      end

      def end_time
        @attributes.fetch('end_time', nil)
      end

      def end_at
        end_time_before_zone.extend(Automatic::CoreExtension::Time).in_zone(self.end_time_zone)
      end

      def end_time_zone
        @attributes.fetch('end_time_zone', nil)
      end

      def start_location
        @start_location ||= Automatic::Client::Location.new(start_location_params)
      end

      def start_time
        @attributes.fetch('start_time', nil)
      end

      def start_at
        start_time_before_zone.extend(Automatic::CoreExtension::Time).in_zone(self.end_time_zone)
      end

      def start_time_zone
        @attributes.fetch('start_time_zone', nil)
      end

      def path
        @attributes.fetch('path', nil)
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

      def fuel_cost_usd
        @attributes.fetch('fuel_cost_usd', 0)
      end
      alias :fuel_cost :fuel_cost_usd

      def fuel_volume_gal
        @attributes.fetch('fuel_volume_gal', 0)
      end
      alias :fuel_volume :fuel_volume_gal

      def average_mpg
        @attributes.fetch('average_mpg', 0)
      end

      private
      def vehicle_params
        @attributes.fetch('vehicle', {})
      end

      def user_params
        @attributes.fetch('user', {})
      end

      def start_location_params
        @attributes.fetch('start_location', {})
      end

      def end_location_params
        @attributes.fetch('end_location', {})
      end

      def start_time_before_zone
        self.start_time.to_s.extend(Automatic::CoreExtension::Time).from_milliseconds
      end

      def end_time_before_zone
        self.end_time.to_s.extend(Automatic::CoreExtension::Time).from_milliseconds
      end
    end
  end
end
