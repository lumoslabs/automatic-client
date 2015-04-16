module Automatic
  module Models
    class Error
      # Returns an instance of an Error domain model
      #
      # @param attributes [Hash] HTTP Error model
      #
      # @return [Automatic::Models::Error]
      def initialize(attributes={})
        @attributes = attributes
      end

      # Returns the HTTP status of the error
      #
      # @return [String]
      def status
        @attributes.fetch('status', nil)
      end

      # Returns the message of the error
      #
      # @return [String]
      def message
        @attributes.fetch('message', nil)
      end

      # Returns the full message of the error
      #
      # @return [String]
      def full_message
        "Status Code: %s, Message: %s" % [self.status, self.message]
      end
    end
  end
end
