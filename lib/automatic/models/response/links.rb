module Automatic
  module Models
    module Response
      class Links
        include Enumerable

        # Build a Links model
        #
        # @param collection [Array] Array of Link Definitions
        #
        # @return [Automatic::Models::Response::Links]
        def initialize(collection)
          @collection = Array(collection)
        end

        # Implement #each to support Enumerable
        #
        # TODO: Allow chainable filters
        #
        # @return [Enumerable]
        def each(&block)
          links_collection.each(&block)
        end

        # Returns the previous link
        #
        # @return [Automatic::Models::Response::Link]
        def previous
          self.select(&:previous?).first
        end

        # Returns true if there is a previous link
        #
        # @return [Boolean]
        def previous?
          !!self.previous
        end

        # Returns the next link
        #
        # @return [Automatic::Models::Response::Link]
        def next
          self.select(&:next?).first
        end

        # Returns true if there is a next link
        #
        # @return [Boolean]
        def next?
          !!self.next
        end

        # Returns the last page
        #
        # @return [Automatic::Models::Response::Link]
        def last_page
          self.select(&:last?).first
        end

        # Returns true if there is a last page
        #
        # @return [Boolean]
        def last_page?
          !!self.last_page
        end

        # Returns the first page
        #
        # @return [Automatic::Models::Response::Link]
        def first_page
          self.select(&:first?).first
        end

        # Returns true if there is a first page
        #
        # @return [Boolean]
        def first_page?
          !!self.first_page
        end

        private
        def links_collection
          @collection.map { |record| Link.new(record) }
        end
      end
    end
  end
end
