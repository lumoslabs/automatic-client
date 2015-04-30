module Automatic
  module Models
    class Device
      # Build an instance of the Automatic Device model
      #
      # @param attributes [Hash]
      #
      # @return [Automatic::Models::Device]
      def initialize(attributes={})
        @attributes = attributes
      end

      # Return the ID of the device
      #
      # @return [String]
      def id
        @attributes['id']
      end

      # Return the URL of the device detail
      #
      # @return [String]
      def url
        @attributes['url']
      end

      # Returns the version of the device
      #
      # @return [Integer]
      def version
        @attributes['version'].to_i
      end
    end
  end
end
