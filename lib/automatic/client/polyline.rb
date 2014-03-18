require 'polylines'

module Automatic
  module Client
    # This is a wrapper around the encoded path
    class Polyline
      def initialize(path)
        @path = path.to_s
      end

      def encoded
        @path
      end

      def decoded
        @decoded ||= Polylines::Decoder.decode_polyline(@path)
      end
    end
  end
end
