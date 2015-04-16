module Automatic
  module Models
    class Location
      include Comparable

      # Returns an instance of the Location model
      #
      # @param attributes [Hash] Automatic Location Definition
      #
      # @return [Automatic::Models::Location]
      def initialize(attributes={})
        @attributes = attributes
      end

      # Used for Comparable
      #
      # @return [Comparable]
      def <=>(other)
        (self.lat <=> other.lat) | (self.lon <=> other.lon)
      end

      # returns the latitude Point of the location
      #
      # @return [Float]
      def lat
        @attributes.fetch('lat', 0).to_f
      end
      alias :latitude :lat

      # Returns the longitude Point of the location
      #
      # @return [Float]
      def lon
        @attributes.fetch('lon', 0).to_f
      end
      alias :longitude :lon
      alias :lng :lon

      # Returns the Coordinates (both Points) as an array
      #
      # @return [Array]
      def coordinates
        [self.lat, self.lon]
      end

      # Returns the accuracy in meters
      #
      # @return [Integer]
      def accuracy_m
        @attributes.fetch('accuracy_m', 0)
      end
      alias :accuracy_in_meters :accuracy_m
    end
  end
end
