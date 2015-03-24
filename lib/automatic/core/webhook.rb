module Automatic
  module Core
    class Webhook
      def initialize(attributes={})
        @attributes = attributes
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
