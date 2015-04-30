require File.expand_path('../device', __FILE__)

module Automatic
  module Models
    class Devices
      include Enumerable

      # Build an instance of the Devices domain model
      #
      # @param collection [Array]
      #
      # @return [Automatic::Models::Devices]
      def initialize(collection)
        @collection = Array(collection)
      end

      # Implement Enumerable
      def each(&block)
        internal_collection.each(&block)
      end

      private
      def internal_collection
        @collection.map { |record| Device.new(record) }
      end
    end
  end
end
