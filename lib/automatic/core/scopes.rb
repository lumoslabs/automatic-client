require File.expand_path('../scope', __FILE__)

module Automatic
  module Core
    class Scopes
      include Enumerable

      def initialize(collection)
        @collection = Array(collection)
      end

      def each(&block)
        record_collection.each(&block)
      end

      def find_by_scope(scope)
        self.select { |record| record.name == scope.to_s }.first
      end

      private
      def record_collection
        @collection.map { |record| Scope.new(record) }
      end
    end
  end
end
