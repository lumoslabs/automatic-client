module Automatic
  module Client
    class Locations
      include Enumerable

      def initialize(collection)
        @collection = Array(collection)
      end

      def each(&block)
        locations_collection.each(&block)
      end

      private
      def locations_collection
        @collection.map { |record| Location.new(record) }
      end
    end
  end
end
