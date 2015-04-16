module Automatic
  module Models
    class Locations
      include Enumerable

      # Returns a collection Proxy for Location domain models
      #
      # @param collection [Array] Array of JSON Automatic Location
      # Definitions
      #
      # @return [Automatic::Models::Locations]
      def initialize(collection)
        @collection = Array(collection)
      end

      # Implement #each for Enumerable support
      #
      # @return [Array]
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
