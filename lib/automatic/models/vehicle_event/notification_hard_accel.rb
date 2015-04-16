module Automatic
  module Models
    module VehicleEvent
      class NotificationHardAccel
        include Comparable

        # Create a Hard Accel event object
        #
        # @param attributes [Hash] Hard Accel Definition
        #
        # @return [Automatic::Models::VehicleEvent::NotificationHardAccel]
        def initialize(attributes={})
          @attributes = attributes
        end

        # Returns the latitude where the event occurred.
        #
        # @return [Float] Latitude Point
        def lat
          @attributes.fetch('lat', nil).to_f
        end
        alias :latitude :lat

        # Returns the longitude where the event occurred.
        #
        # @return [Float] Longitude Point
        def lon
          @attributes.fetch('lon', nil).to_f
        end
        alias :lng :lon
        alias :longitude :lon

        # Returns the type of the event. This is helpful since
        # we have a polymorphic list of events.
        #
        # @return [String] Event type (name)
        def type
          @attributes.fetch('type', nil)
        end

        # Returns the G Force of the accel event.
        #
        # @return [Float]
        def g_force
          @attributes.fetch('g_force', 0).to_f
        end

        # Returns the time the event was created. This is
        # returned in ISO8601.
        #
        # @return [DateTime,nil]
        def created_at
          begin
            DateTime.parse(@attributes.fetch('created_at', nil))
          rescue
            nil
          end
        end
      end
    end
  end
end
