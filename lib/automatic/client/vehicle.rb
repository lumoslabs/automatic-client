module Automatic
  module Client
    class Vehicle
      def initialize(attributes={})
        @attributes = attributes
      end

      def id
        @attributes.fetch('id', nil)
      end

      def url
        @attributes.fetch('url', nil)
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

      def sub_model
        @attributes.fetch('submodel', nil)
      end

      def color
        @attributes.fetch('color', nil)
      end

      def full_name
        [self.year, self.make, self.model, self.sub_model].join(' ')
      end

      def display_name
        @attributes.fetch('display_name', nil)
      end
    end
  end
end
