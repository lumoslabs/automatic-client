module Automatic
  module Models
    class UserMetadata
      # Build the metadata associated with the User
      #
      # @param attributes [Hash] User Metadata Definition
      #
      # @return [Automatic::Models::UserMetadata]
      def initialize(attributes={})
        @attributes = attributes
      end

      # Returns the URL of this object
      #
      # @return [String]
      def url
        @attributes.fetch('url', nil)
      end

      # Returns the User URL of this object
      #
      # TODO: Extract to a User object
      #
      # @return [String]
      def user
        @attributes.fetch('user', nil)
      end

      # Returns the firmware version for the User
      #
      # @return [String]
      def firmware_version
        @attributes.fetch('firmware_version', nil)
      end

      # Returns the app version for the User
      #
      # @return [String]
      def app_version
        @attributes.fetch('app_version', nil)
      end

      # Returns the OS version for the User
      #
      # @return [String]
      def os_version
        @attributes.fetch('os_version', nil)
      end

      # Returns the device type for the User
      #
      # @return [String]
      def device_type
        @attributes.fetch('device_type', nil)
      end

      # Returns the phone platform for the User
      #
      # NOTE: Could there be multiple here?
      #
      # @return [String]
      def phone_platform
        @attributes.fetch('phone_platform', nil)
      end

      # Returns true if User is on the latest app version
      #
      # @return [Boolean]
      def is_latest_app_version
        @attributes.fetch('is_latest_app_version', false)
      end
      alias :latest_app_version? :is_latest_app_version
    end
  end
end
