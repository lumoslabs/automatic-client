module Automatic
  module Models
    class Trips
      include Enumerable

      RecordNotFoundError = Class.new(StandardError)

      # Creates a new instance of the Trips Collection. This is
      # used to wrap the vehicles and allow extra support for finders,
      # sorting, and grouping
      #
      # @param collection [Array] A collection of Automatic Trip Definitions
      #
      # @return [Automatic::Models::Trips] Instance of the object
      def initialize(collection={})
        @collection = Array(collection)
      end

      # Find a Trip by the specified ID
      #
      # @param id [String] The Automatic Trip ID
      # @param options [Hash] HTTP Query String Parameters
      #
      # @raise [RecordNotFoundError] if no Trip can be found
      #
      # @return [Automatic::Models::Trip] Automatic Trip Model
      def self.find_by_id!(id, options={})
        trip = self.find_by_id(id, options)

        raise RecordNotFoundError.new("Could not find Trip with ID %s" % [id]) if trip.nil?

        trip
      end

      # Find a Trip by the specified ID
      #
      # @param id [String] The Automatic Trip ID
      # @param options [Hash] HTTP Query String Parameters
      #
      # @return [Automatic::Models::Trip,Nil]
      def self.find_by_id(id, options={})
        trip_route = Automatic::Client.routes.route_for('trip')
        trip_url   = trip_route.url_for(id: id)

        request = Automatic::Client.get(trip_url, options)

        if request.success?
          Automatic::Models::Trip.new(request.body)
        else
          nil
        end
      end

      # Make a connection to Automatic to retrieve all trips. By default
      # we will stream until we have all trips. You can set `per_page` and `page` in the request.
      #
      # @param options [Hash] Options to send to the HTTP request.
      #
      # @return [Automatic::Model::Trips] Automatic Trips Model
      def self.all(options={})
        paginate = if options.has_key?(:paginate)
                     options.delete(:paginate)
                   else
                     true
                   end

        trips_route = Automatic::Client.routes.route_for('trips')
        trips_url   = trips_route.url_for

        request = Automatic::Client.get(trips_url, options)

        if request.success?
          raw_trips = []

          link_header = Automatic::Models::Response::LinkHeader.new(request.headers['Link'])
          links       = link_header.links

          raw_trips.concat(request.body.fetch('results', []))

          if links.next? && paginate
            loop do
              request   = Automatic::Client.get(links.next.uri)

              link_header = Automatic::Models::Response::LinkHeader.new(request.headers['Link'])
              links       = link_header.links

              raw_trips.concat(request.body.fetch('results', []))

              break unless links.next?
            end
          end

          self.new(raw_trips)
        else
          raise StandardError.new(request.body)
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
