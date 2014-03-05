module Automatic
  module Client
    module Response
      class LinkHeader
        InvalidLinkHeaderError = Class.new(StandardError)

        include Enumerable

        def initialize(header=nil)
          @header = header.to_s
        end

        def each(&block)
          links_collection.each(&block)
        end

        private
        def links_collection
          @links_collection ||= extract!
        end

        def extract!
          links = []

          if @header
            parts = @header.split(',')

            parts.each do |part|
              section = part.split(';')

              raise InvalidLinkHeaderError.new('Invalid Link Header') if section.size != 2

              url  = section[0].gsub(/<(.*)>/, '\1').strip
              rel  = section[1].gsub(/rel="(.*)"/, '\1').strip

              links << Link.new(uri: url, rel: rel)
            end
          end

          links
        end
      end
    end
  end
end
