module Automatic
  module Core
    class Webhook
      def initialize(attributes={})
        @attributes = attributes
      end

      def name
        @attributes.fetch('name', nil)
      end

      def type
        self.name.split(':', 2).last
      end

      def description
        @attributes.fetch('description', nil)
      end
    end
  end
end
