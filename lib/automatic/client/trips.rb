module Automatic
  module Client
    class Trips
      include Enumerable

      # Creates a new instance of the Trips Collection. This is
      # used to wrap the vehicles and allow extra support for finders,
      # sorting, and grouping
      #
      # @return [Trips] Instance of the object
      def initialize(collection={})
        @collection = Array(collection)
      end

      # Method needed for Enumerable support
      #
      # @return [Array, Trips] A collection of Trip objects
      def each(&block)
        vehicles_collection.each(&block)
      end

      private
      def vehicles_collection
        @collection.map { |record| Trip.new(record) }
      end
    end
  end
end
