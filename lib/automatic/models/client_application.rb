module Automatic
  module Models
    class ClientApplication
      # Build an instance of the Automatic ClientApplication domain model
      #
      # This is used to let users know what applications they have
      # authenticated with.
      #
      # @param attributes [Hash]
      #
      # @return [Automatic::Models::ClientApplication]
      def initialize(attributes={})
        @attributes = attributes
      end

      # Returns the ID of the clienit application
      #
      # @return [String]
      def id
        @attributes['id']
      end
    end
  end
end
