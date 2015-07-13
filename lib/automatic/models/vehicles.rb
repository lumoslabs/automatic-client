module Automatic
  module Models
    class Vehicles
      include Enumerable

      attr_reader :api_client

      RecordNotFoundError = Class.new(StandardError)

      # Creates a new instance of the Vehicles collection. This is
      # used to wrap the vehicles and allow extra support for finders,
      # sorting, and grouping
      #
      # @param collection [Array] A collection of Automatic Vehicle Definitions
      #
      # @return [Automatic::Models::Vehicles] Instance of the object
      def initialize(api_client = Automatic::Client)
        @api_client = api_client
      end

      def self.method_missing(method_sym, *arguments, &block)
        super unless method_defined?(method_sym)

        self.new.send(method_sym, *arguments, &block)
      end

      # Find a Vehicle by the specified ID
      #
      # @param id [String] The Automatic Vehicle ID
      # @param options [Hash] HTTP Query String Parameters
      #
      # @return [Automatic::Models::Vehicle,Nil]
      def find_by_id(id, options={})
        vehicle_route = Automatic::Client.routes.route_for('vehicle')
        vehicle_url   = vehicle_route.url_for(id: id)

        request = api_client.get(vehicle_url, options)

        if request.success?
          Automatic::Models::Vehicle.new(request.body)
        else
          nil
        end
      end

      # Find a Vehicle by the specified ID
      #
      # @param id [String] The Automatic Vehicle ID
      # @param options [Hash] HTTP Query String Parameters
      #
      # @raise [RecordNotFoundError] if no Vehicle can be found
      #
      # @return [Automatic::Models::Vehicle,Nil]
      def find_by_id!(id, options={})
        vehicle = find_by_id(id, options)

        raise RecordNotFoundError.new("Could not find Vehicle with ID %s" % [id]) if vehicle.nil?

        vehicle
      end

      # Make a connection to Automatic to retrieve all vehicles.
      #
      # @param options [Hash] Options to send to the HTTP Request
      #
      # @return [Automatic::Models::Vehicles] Automatic Vehicles Model
      def all(options={})
        @collection = collect_all(options)
        self
      end

      def collect_all(options = {})
        vehicles_route = Automatic::Client.routes.route_for('vehicles')
        vehicles_url   = vehicles_route.url_for

        request = api_client.get(vehicles_url, options)

        if request.success?
          raw_vehicles = []

          metadata    = Automatic::Models::Response::Metadata.new(request.body.fetch('_metadata', {}))
          link_header = Automatic::Models::Response::LinkHeader.new(request.headers['Link'])
          links       = link_header.links

          raw_vehicles.concat(request.body.fetch('results', []))

          if links.next?
            loop do
              request = api_client.get(links.next.uri)

              link_header = Automatic::Models::Response::LinkHeader.new(request.headers['Link'])
              links       = link_header.links

              raw_vehicles.concat(request.body.fetch('results', []))

              break unless links.next?
            end
          end

          raw_vehicles
        else
          raise StandardError.new(request.body)
        end
      end

      # Implemented to support Enumerable
      #
      # @return [Array,Automatic::Models::Vehicle]
      def each(&block)
        vehicles_collection.each(&block)
      end

      private
      def vehicles_collection
        (@collection || collect_all).map { |record| Vehicle.new(record) }
      end
    end
  end
end
