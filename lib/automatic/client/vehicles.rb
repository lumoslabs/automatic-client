module Automatic
  module Client
    class Vehicles
      include Enumerable

      def initialize(collection={})
        @collection = Array(collection)
      end

      def each(&block)
        vehicles_collection.each(&block)
      end

      private
      def vehicles_collection
        @collection
      end
    end
  end
end
