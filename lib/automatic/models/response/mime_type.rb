module Automatic
  module Models
    module Response
      class MimeType
        # Creates an instance of the Mime Type
        #
        # @param attributes [Hash] Mime Type Definition
        #
        # @return [Automatic::Models::Response::MimeType]
        def initialize(attributes={})
          @attributes = attributes
        end

        # Returns the name of the mime type
        #
        # @return [String]
        def name
          @attributes['name']
        end
      end
    end
  end
end
