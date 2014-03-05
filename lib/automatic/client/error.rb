module Automatic
  module Client
    class Error
      def initialize(attributes={})
        @attributes = attributes
      end

      def status
        @attributes.fetch('status', nil)
      end

      def message
        @attributes.fetch('message', nil)
      end

      def full_message
        "Status Code: %s, Message: %s" % [self.status, self.message]
      end
    end
  end
end
