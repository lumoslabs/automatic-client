module Automatic
  module Client
    module Response
      class Metadata
        # Create an instance of a new Metadata object
        #
        def initialize(attributes={})
          @attributes = attributes
        end

        # Return the total number of items in the collection
        #
        # @return [Integer]
        def count
          @attributes.fetch('count', 0).to_i
        end

        # Helper method to return true if there are any items
        # in the collection
        #
        # @return [Boolean]
        def any?
          self.count > 0
        end

        # Returns the URI of the next link if available
        #
        # @return [String,Nil]
        def next
          @attributes['next']
        end

        # Returns true if there is a next link
        #
        # @return [Boolean]
        def next?
          !self.next.nil?
        end

        # Returns the URI of the previous link if available
        #
        # @return [String,Nil]
        def previous
          @attributes['previous']
        end

        # Returns true if there is a previous link
        #
        # @return [Boolean]
        def previous?
          !self.previous.nil?
        end
      end
    end
  end
end
