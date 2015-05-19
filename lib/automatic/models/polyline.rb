require 'polylines'

module Automatic
  module Models
    class Polyline
      # This is a wrapper around the encoded path
      #
      # @param path [String] Encoded Polyline Path
      #
      # @return [Automatic::Models::Polyline]
      def initialize(path)
        @path = path.to_s
      end

      # Return the encoded path
      #
      # @return [String]
      def encoded
        @path
      end

      # Return the decoded path
      #
      # @return [Polylines::Decoder]
      def decoded
        @decoded ||= Polylines::Decoder.decode_polyline(@path)
      end
    end
  end
end
