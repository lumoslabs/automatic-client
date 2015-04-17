require File.expand_path('../mime_type.rb', __FILE__)

module Automatic
  module Models
    module Response
      class MimeTypes
        include Enumerable

        # Create a Mime Types domain model.
        #
        # @param collection [Array] A collection of Mime Type definitions
        #
        # @return [Automatic::Models::Response::MimeTypes]
        def initialize(collection)
          @collection = Array(collection)
        end

        # Implement Enumerable
        def each(&block)
          internal_collection.each(&block)
        end

        private
        def internal_collection
          @collection.map do |record|
            record_attributes = {
              'name' => record
            }
            MimeType.new(record_attributes)
          end
        end
      end
    end
  end
end
