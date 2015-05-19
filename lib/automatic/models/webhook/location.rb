module Automatic
  module Models
    module Webhook
      class Location
        # Return an instance of the Webhook Location model
        #
        # @param attributes [Hash]
        #
        # @return [Automatic::Models::Webhook::Location]
        def initialize(attributes={})
          @attributes = attributes
        end

        # Returns the name of the location
        #
        # @return [String]
        def name
          @attributes['name']
        end

        # Returns the display name of the location
        #
        # @return [String]
        def display_name
          @attributes['display_name']
        end

        # Returns the latitude of the location
        #
        # @return [Float]
        def lat
          @attributes['lat']
        end
        alias :latitude :lat

        # Returns the longitude of the location
        #
        # @return [Float]
        def lon
          @attributes['lon'].to_f
        end
        alias :longitude :lon
        alias :lng :lon

        # Returns the accuracy in meters of the location
        #
        # @return [Integer]
        def accuracy_m
          @attributes['accuracy_m'].to_i
        end
      end
    end
  end
end
