module Automatic
  module Client
    class Vehicles
      include Enumerable

      def initialize(collection)
        @collection = Array(collection)
      end

      def self.find_by_id(id, options={})
        id = id.to_s

        route = Automatic::Client.routes.route_for('vehicle')

        request   = Automatic::Client::Request.get(route.url_for(id: id), options)
        response  = request
        json_body = MultiJson.load(response.body)

        case(response.status)
        when 200
          Automatic::Client::Vehicle.new(json_body)
        else
          json_body.merge!('status' => response.status)
          error = Automatic::Client::Error.new(json_body)

          raise StandardError.new(error.full_message)
        end
      end

      def self.all(options={})
        route = Automatic::Client.routes.route_for('vehicles')

        request   = Automatic::Client::Request.get(route.url_for, options)
        response  = request
        json_body = MultiJson.load(response.body)

        case(response.status)
        when 200
          raw_vehicles = []

          metadata    = Automatic::Client::Response::Metadata.new(json_body.fetch('_metadata', {}))
          link_header = Automatic::Client::Response::LinkHeader.new(response.headers['Link'])
          links       = link_header.links

          raw_vehicles.concat(json_body.fetch('results', []))

          if links.next?
            loop do
              request   = Automatic::Client::Request.get(links.next.uri, options)
              response  = request
              json_body = MultiJson.load(response.body)

              link_header = Automatic::Client::Response::LinkHeader.new(response.headers['Link'])
              links       = link_header.links

              raw_vehicles.concat(json_body.fetch('results', []))

              break unless links.next?
            end
          end

          self.new(raw_vehicles)
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

      def each(&block)
        vehicles_collection.each(&block)
      end

      private
      def vehicles_collection
        @collection.map { |record| Vehicle.new(record) }
      end
    end
  end
end
