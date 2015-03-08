module Automatic
  module Client
    class User
      def initialize(attributes={})
        @attributes = attributes
      end

      def id
        @attributes.fetch('id', nil)
      end

      def url
        @attributes.fetch('url', nil)
      end

      def username
        @attributes.fetch('username', nil)
      end

      def first_name
        @attributes.fetch('first_name', nil)
      end

      def last_name
        @attributes.fetch('last_name', nil)
      end

      def full_name
        [self.first_name, self.last_name].join(' ')
      end

      def email
        @attributes.fetch('email', nil)
      end
    end
  end
end
