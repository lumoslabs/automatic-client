module Automatic
  module Models
    module VehicleEvent
      class NotificationSpeeding
        include Comparable

        # Create a SpeedingEvent object
        #
        # @param attributes [Hash] Speeding Event Definition
        #
        # @return [Automatic::Models::VehicleEvent::NotificationSpeeding]
        def initialize(attributes={})
          @attributes = attributes
        end

        # Sort by the started at of the event by default
        #
        # @return [Comparable]
        def <=>(other)
          self.started_at <=> other.started_at
        end

        # Return the start distance in meters
        #
        # @return [String]
        def start_distance_m
          @attributes.fetch('start_distance_m', nil)
        end

        # Return the end distance in meters
        #
        # @return [String]
        def end_distance_m
          @attributes.fetch('end_distance_m', nil)
        end

        # Returns the veolcity kilometers per hour
        #
        # @return [String]
        def velocity_kph
          @attributes.fetch('velocity_kph', nil)
        end

        # Returns the type of the event
        #
        # @return [String]
        def type
          @attributes.fetch('type', nil)
        end

        # Returns the calculated duration of the event
        #
        # @return [Integer]
        def duration
          (self.ended_at.to_time - self.started_at.to_time)
        end

        # Returns the time the event started
        #
        # @return [DateTime]
        def started_at
          begin
            DateTime.parse(@attributes.fetch('started_at', nil))
          rescue
            nil
          end
        end

        # Returns the time the event ended
        #
        # @return [DateTime]
        def ended_at
          begin
            DateTime.parse(@attributes.fetch('ended_at', nil))
          rescue
            nil
          end
        end
      end
    end
  end
end