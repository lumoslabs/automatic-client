module Automatic
  module Client
    class Trips
      UnauthorizedError = Class.new(StandardError)

      include Enumerable

      # Creates a new instance of the Trips Collection. This is
      # used to wrap the vehicles and allow extra support for finders,
      # sorting, and grouping
      #
      # @return [Trips] Instance of the object
      def initialize(collection={})
        @collection = Array(collection)
      end

      def self.find_by_id(id, options={})
        route = Automatic::Client.routes.route_for('trip')

        request   = Automatic::Client::Request.get(route.url_for(id: id), options)
        response  = request
        json_body = MultiJson.load(response.body)

        case(response.status)
        when 200
          Automatic::Client::Trip.new(json_body)
        else
          json_body.merge!('status' => response.status)
          error = Automatic::Client::Error.new(json_body)

          raise StandardError.new(error.full_message)
        end
      end

      # Make a connection to Automatic to retrieve all trips. By default
      # we will stream until we have all trips. You can set `per_page` and `page` in the request.
      #
      # # NOTE: This will be the first item to refactor!
      #
      # @return [Array, Trips] Array of trip records
      def self.all(options={})
        route = Automatic::Client.routes.route_for('trips')

        request   = Automatic::Client::Request.get(route.url_for, options)
        response  = request
        json_body = MultiJson.load(response.body)

        case(response.status)
        when 200
          raw_trips = []

          link_header = Automatic::Client::Response::LinkHeader.new(response.headers['Link'])
          links       = link_header.links

          raw_trips.concat(json_body.fetch('results', []))

          if links.next? && false
            loop do
              request   = Automatic::Client::Request.get(links.next.uri, options)
              response  = request
              json_body = MultiJson.load(response.body)

              link_header = Automatic::Client::Response::LinkHeader.new(response.headers['Link'])
              links       = link_header.links

              raw_trips.concat(json_body.fetch('results', []))

              break unless links.next?
            end
          end

          self.new(raw_trips)
        when 403
          json_body.merge!('status' => 403)
          error = Automatic::Client::Error.new(json_body)

          raise UnauthorizedError.new(error.full_message)
        else
          json_body.merge!('status' => 403)
          error = Automatic::Client::Error.new(json_body)

          raise StandardError.new(error.full_message)
        end
      end

      # Method needed for Enumerable support
      #
      # @return [Array, Trips] A collection of Trip objects
      def each(&block)
        vehicles_collection.each(&block)
      end

      private
      def vehicles_collection
        @collection.map { |record| Trip.new(record) }
      end
    end
  end
end
