module Automatic
  module Client
    class User
      def initialize(attributes={})
        @attributes = attributes
      end

      def id
        @attributes.fetch('id', nil)
      end
    end
  end
end
