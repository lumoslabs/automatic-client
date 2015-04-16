module Automatic
  module Models
    module VehicleEvent
      # Returns an instance of a Hard Brake event
      # within the Trip collection
      class NotificationHardBrake
        include Comparable

        # Create a Hard Brake event object
        #
        # @param attributes [Hash] Hard Brake Definition
        #
        # @return [Automatic::Models::VehicleEvent::NotificationHardBrake]
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

        # Returns the G Force of the brake event.
        #
        # @return [Float]
        def g_force
          @attributes.fetch('g_force', 0).to_f
        end

        # Returns the time the event was created. This is
        # returned in ISO8601
        #
        # @return [DateTime,Nil]
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
