module Automatic
  module Models
    class Tag
      include Comparable

      # Create an instance of the Automatic Tag model
      #
      # @param attributes [Hash] Hash of the Automatic Tag Model
      #
      # @return [Automatic::Models::Tag]
      def initialize(attributes={})
        @attributes = attributes
      end

      # Implement Comparable
      #
      # @return [Automatic::Models::Tag]
      def <=>(other)
        self.tag <=> other.tag
      end

      # Returns the tag label
      #
      # @return [String]
      def tag
        @attributes.fetch('tag', nil)
      end
      alias :name :tag

      # Returns the timestamp when the
      # tag was created.
      #
      # @return [DateTime]
      def created_at
        begin
          DateTime.parse(@attributes.fetch('created_at', nil))
        rescue
          nil
        end
      end
    end
  end
end
