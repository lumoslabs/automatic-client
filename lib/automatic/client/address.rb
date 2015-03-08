module Automatic
  module Client
    class Address
      def initialize(attributes={})
        @attributes = attributes
      end

      def name
        @attributes.fetch('name', nil)
      end

      def display_name
        @attributes.fetch('display_name', nil)
      end

      def street_number
        @attributes.fetch('street_number', nil)
      end

      def street_name
        @attributes.fetch('street_name', nil)
      end

      def state
        @attributes.fetch('state', nil)
      end

      def city
        @attributes.fetch('city', nil)
      end

      def country
        @attributes.fetch('country', nil)
      end
    end
  end
end
