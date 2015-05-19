module Automatic
  module Core
    class Error
      def initialize(attributes={})
        @attributes = attributes
      end

      def code
        @attributes.fetch('code', 0).to_i
      end

      def name
        @attributes.fetch('name', nil)
      end

      def description
        @attributes.fetch('description', nil)
      end
    end
  end
end
