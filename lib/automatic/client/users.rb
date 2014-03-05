module Automatic
  module Client
    class Users
      include Enumerable

      def initialize(collection)
        @collection = Array(collection)
      end

      def each(&block)
        users_collection.each(&block)
      end

      private
      def users_collection
        @collection.map { |record| User.new(record) }
      end
    end
  end
end
