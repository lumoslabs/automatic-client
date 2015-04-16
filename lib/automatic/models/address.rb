module Automatic
  module Models
    class Address
      # Returns an instance of an Address domain model
      #
      # @note It would be a nice to have if this included
      # the postal code as well.
      #
      # @param attributes [Hash] Automatic Address model
      #
      # @return [Automatic::Models::Address]
      def initialize(attributes={})
        @attributes = attributes
      end

      # Returns the full name of the address. This includes
      # the street number, street name, city, state, postal
      # code, and country.
      #
      # @return [String]
      def name
        @attributes.fetch('name', nil)
      end

      # Returns the display name of the address. This includes
      # the street name, city, and state.
      #
      # @return [String]
      def display_name
        @attributes.fetch('display_name', nil)
      end

      # Returns the street number
      #
      # @return [String]
      def street_number
        @attributes.fetch('street_number', nil)
      end

      # Returns the street name
      #
      # @return [String]
      def street_name
        @attributes.fetch('street_name', nil)
      end

      # Returns the state name
      #
      # @todo Move to a State model that has
      # the state name and code.
      #
      # @return [String]
      def state
        @attributes.fetch('state', nil)
      end

      # Returns the city name
      #
      # @return [String]
      def city
        @attributes.fetch('city', nil)
      end

      # Returns the country
      #
      # @return [String]
      def country
        @attributes.fetch('country', nil)
      end
    end
  end
end
