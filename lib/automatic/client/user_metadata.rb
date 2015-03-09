module Automatic
  module Client
    class UserMetadata
      def initialize(attributes={})
        @attributes = attributes
      end

      def url
        @attributes.fetch('url', nil)
      end

      def user
        @attributes.fetch('user', nil)
      end

      def firmware_version
        @attributes.fetch('firmware_version', nil)
      end

      def app_version
        @attributes.fetch('app_version', nil)
      end

      def os_version
        @attributes.fetch('os_version', nil)
      end

      def device_type
        @attributes.fetch('device_type', nil)
      end

      def phone_platform
        @attributes.fetch('phone_platform', nil)
      end

      def is_latest_app_version
        @attributes.fetch('is_latest_app_version', false)
      end
      alias :latest_app_version? :is_latest_app_version
    end
  end
end
