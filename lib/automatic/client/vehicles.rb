module Automatic
  module Client
    class Vehicles
      include Enumerable

      def initialize(collection)
        @collection = Array(collection)
      end

      def self.all(options={})
        request   = Automatic::Client::Request.get('/v1/vehicles', options)
        response  = request
        json_body = MultiJson.load(response.body)

        case(response.status)
        when 200
          raw_vehicles = []

          link_header = Automatic::Client::Response::LinkHeader.new(response.headers['Link'])
          links       = link_header.links

          raw_vehicles.concat(json_body)

          if links.next?
            loop do
              request   = Automatic::Client::Request.get(links.next.uri, options)
              response  = request
              json_body = MultiJson.load(response.body)

              link_header = Automatic::Client::Response::LinkHeader.new(response.headers['Link'])
              links       = link_header.links

              raw_vehicles.concat(json_body)

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
