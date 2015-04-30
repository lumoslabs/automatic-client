module Automatic
  module Models
    module Response
      class Options
        # When performing HTTP OPTIONS, we receive
        # a response that lets us know what is available
        # at this endpoint.
        #
        # @note We would like some more extended information, but
        # this will do for now
        #
        # @param attributes [Hash] Model of the OPTIONS response
        #
        # @return [Automatic::Response::Options]
        def initialize(attributes={})
          @attributes = attributes
        end

        # Returns the name of the requested
        # entity.
        #
        # @return [String]
        def name
          @attributes['name']
        end

        # Returns the description of the requested
        # entity.
        #
        # @return [String]
        def description
          @attributes['description']
        end

        # Returns a collection of available
        # renderers.
        #
        # @return [Array]
        def renders
          @renders ||= Automatic::Models::Response::MimeTypes.new(@attributes.fetch('renders', []))
        end

        # Returns a collection of available
        # parsers.
        #
        # @return [Array]
        def parses
          @parses ||= Automatic::Models::Response::MimeTypes.new(@attributes.fetch('parses', []))
        end
      end
    end
  end
end
