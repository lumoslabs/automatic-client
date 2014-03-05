module Automatic
  module Client
    class Location
      include Comparable

      def initialize(attributes={})
        @attributes = attributes
      end

      def <=>(other)
        (self.lat <=> other.lat) | (self.lon <=> other.lon)
      end

      def name
        @attributes.fetch('name', nil)
      end

      def name?
        !!self.name
      end

      def lat
        @attributes.fetch('lat', 0).to_f
      end
      alias :latitude :lat

      def lon
        @attributes.fetch('lon', 0).to_f
      end
      alias :longitude :lon

      def coordinates
        [self.lat, self.lon]
      end

      def accuracy_m
        @attributes.fetch('accuracy_m', 0)
      end
      alias :accuracy_in_meters :accuracy_m
    end
  end
end
