require File.expand_path('../client_application', __FILE__)

module Automatic
  module Models
    class ClientApplications
      include Enumerable

      # Build an instance of the Automatic ClientApplications domain model
      #
      # @param collection [Array]
      #
      # @return [Automatic::Models::ClientApplications]
      def initialize(collection)
        @collection = Array(collection)
      end

      # Implement Enumerable
      def each(&block)
        internal_collection.each(&block)
      end

      private
      def internal_collection
        @collection.map { |record| ClientApplication.new(record) }
      end
    end
  end
end
