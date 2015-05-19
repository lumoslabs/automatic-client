module Automatic
  module Models
    class User
      # Create an instance of a User
      #
      # @param attributes [Hash] User attributes
      #
      # @return [Automatic::Models::User]
      def initialize(attributes={})
        @attributes = attributes
      end

      # Returns the ID of the User
      #
      # @return [String] Automatic ID
      def id
        @attributes.fetch('id', nil)
      end

      # Returns the URL of the User
      #
      # @return [String] User detail endpoint
      def url
        @attributes.fetch('url', nil)
      end

      # Returns the username of the User
      #
      # @return [String]
      def username
        @attributes.fetch('username', nil)
      end

      # Returns the User first name
      #
      # @return [String,Nil]
      def first_name
        @attributes.fetch('first_name', nil)
      end

      # Return the User last name
      #
      # @return [String,Nil]
      def last_name
        @attributes.fetch('last_name', nil)
      end

      # Return the User full name
      #
      # @return [String]
      def full_name
        [self.first_name, self.last_name].join(' ')
      end

      # Return the User email address
      #
      # @return [String]
      def email
        @attributes.fetch('email', nil)
      end
    end
  end
end
