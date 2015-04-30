module Automatic
  module Models
    module Webhook
      class Region
        # Return a Webhook Region instance for RegionChanged
        # event
        #
        # @param attributes [Hash]
        #
        # @return [Automatic::Models::Webhook::Region]
        def initialize(attributes={})
          @attributes = attributes
        end

        # Returns the name of the region
        #
        # @return [String]
        def name
          @attributes['name']
        end

        # Returns the status
        #
        # @return [String]
        def status
          @attributes['status']
        end

        # Returns the latitude of the region
        #
        # @return [Float]
        def lat
          @attributes['lat'].to_f
        end
        alias :latitude :lat

        # Returns the longitude of the region
        #
        # @return [Float]
        def lon
          @attributes['lon'].to_f
        end
        alias :longitude :lon
        alias :lng :lon

        # It returns the radius in meters
        #
        # @return [Float]
        def radius_m
          @attributes['radius_m'].to_f
        end
      end
    end
  end
end
