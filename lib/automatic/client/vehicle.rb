module Automatic
  module Client
    class Vehicle
      def initialize(attributes={})
        @attributes = attributes
      end

      def id
        @attributes.fetch('id', nil)
      end

      def uri
        @attributes.fetch('uri', nil)
      end

      def year
        @attributes.fetch('year', nil)
      end

      def make
        @attributes.fetch('make', nil)
      end

      def model
        @attributes.fetch('model', nil)
      end

      def color
        @attributes.fetch('color', nil)
      end

      def display_name
        @attributes.fetch('display_name', nil)
      end
    end
  end
end
