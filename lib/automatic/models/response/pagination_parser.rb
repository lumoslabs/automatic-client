require 'addressable/uri'

module Automatic
  module Models
    module Response
      class PaginationParser
        # Create a PaginationParser instance
        #
        # @param url [String] URL to extract pagination from
        #
        # @return [Automatic::Models::Response::PaginationParser]
        def initialize(uri)
          @uri = uri
        end

        # Return a Pagination object
        #
        # @return [Pagination] Pagination object with specific details
        def pagination
          @pagination ||= Pagination.new(pagination_params)
        end

        private
        def parsed_uri
          @parsed_uri ||= begin
                            Addressable::URI.parse(@uri)
          rescue
            {}
          end
        end

        def query_params
          (parsed_uri.query_values || {})
        end

        def pagination_params
          {
            :page     => query_params.fetch('page', 0),
            :per_page => query_params.fetch('per_page', 100)
          }
        end
      end
    end
  end
end
