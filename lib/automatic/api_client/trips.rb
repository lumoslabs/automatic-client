module Automatic
  class ApiClient
    def trips
      Trips.new(self)
    end

    class Trips
      attr_reader :api_client

      def initialize(api_client)
        @api_client = api_client
      end

      # Make a connection to Automatic to retrieve all trips. By default
      # we will stream until we have all trips. You can set `per_page` and `page` in the request.
      #
      # @param options [Hash] Options to send to the HTTP request.
      #
      # @return [Automatic::Model::Trips] Automatic Trips Model
      def all(options={})
        paginate = if options.has_key?(:paginate)
                     options.delete(:paginate)
                   else
                     true
                   end

        trips_route = Automatic::Client.routes.route_for('trips')
        trips_url   = trips_route.url_for

        request = api_client.get(trips_url, options)

        if request.success?
          raw_trips = []

          link_header = Automatic::Models::Response::LinkHeader.new(request.headers['Link'])
          links       = link_header.links

          raw_trips.concat(request.body.fetch('results', []))

          if links.next? && paginate
            loop do
              request = api_client.get(links.next.uri)

              link_header = Automatic::Models::Response::LinkHeader.new(request.headers['Link'])
              links       = link_header.links

              raw_trips.concat(request.body.fetch('results', []))

              break unless links.next?
            end
          end

          ::Automatic::Models::Trips.new(raw_trips)
        else
          raise StandardError.new(request.body)
        end
      end
    end
  end
end
