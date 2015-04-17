require File.expand_path('../tagging.rb', __FILE__)

module Automatic
  module Models
    class Taggings
      BUSINESS_SLUG = 'business'.freeze

      include Enumerable

      # Return a collection of Automatic Tagging models
      #
      # @param collection [Array] JSON Automatic Tagging Models
      #
      # @return [Automatic::Models::Taggings]
      def initialize(collection)
        @collection = Array(collection)
      end

      # Imeplement Enumerable
      def each(&block)
        internal_collection.each(&block)
      end

      # Find a tagging by a given name
      #
      # @note We want to return an array proxy here
      #
      # @return [Array]
      def find_by_tag(name)
        self.select { |record| record.name == name.to_s }.first
      end

      # Helper method to return the tag business tag
      #
      # @return [Automatic::Models::Tagging,nil]
      def business
        self.find_by_tag(BUSINESS_SLUG)
      end

      # Returns true if there is a business tag in the collection.
      #
      # @return [Boolean]
      def business?
        !self.business.nil?
      end

      private
      def internal_collection
        @collection.map { |record| Tagging.new(record) }
      end
    end
  end
end
