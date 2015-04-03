module Automatic
  module Models
    class Vehicle
      # Builds an object for the Vehicle
      #
      # @param attributes [Hash] Hash of the Vehicle Definition
      #
      # @return [Automatic::Models::Vehicle]
      def initialize(attributes={})
        @attributes = attributes
      end

      # Returns the ID of the Vehicle
      #
      # @return [String]
      def id
        @attributes.fetch('id', nil)
      end

      # Returns the URL of the Vehicle
      #
      # @return [String]
      def url
        @attributes.fetch('url', nil)
      end

      # Returns the year of the Vehicle
      #
      # @return [String]
      def year
        @attributes.fetch('year', nil)
      end

      # Returns the make of the Vehicle
      #
      # @return [String]
      def make
        @attributes.fetch('make', nil)
      end

      # Returns the model of the Vehicle
      #
      # @return [String]
      def model
        @attributes.fetch('model', nil)
      end

      # Returns the sub model of the Vehicle
      #
      # @return [String]
      def sub_model
        @attributes.fetch('submodel', nil)
      end

      # Returns the color of the Vehicle
      #
      # This is specified by the user.
      #
      # @return [String]
      def color
        @attributes.fetch('color', nil)
      end

      # Returns the full name of the Vehicle
      #
      # This is built from the official vehicle details
      #
      # @return [String]
      def full_name
        [self.year, self.make, self.model, self.sub_model].join(' ')
      end

      # Returns the display name of the Vehicle
      #
      # This is specified by the user
      #
      # @return [String]
      def display_name
        @attributes.fetch('display_name', nil)
      end
    end
  end
end
