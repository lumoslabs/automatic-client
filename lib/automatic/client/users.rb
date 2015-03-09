module Automatic
  module Client
    class Users
      include Enumerable

      def self.find_by_id(id, options={})
        route = Automatic::Client.routes.route_for('user')

        request       = Automatic::Client::Request.get(route.url_for(id: id), options)
        response      = request
        response_body = MultiJson.load(response.body)

        case(response.status)
        when 200
          Automatic::Client::User.new(response_body)
        else
          response_body.merge!('status' => response.status, 'message' => response_body['detail'])
          error = Automatic::Client::Error.new(response_body)

          raise StandardError.new(error.full_message)
        end
      end

      def initialize(collection)
        @collection = Array(collection)
      end

      def each(&block)
        users_collection.each(&block)
      end

      private
      def users_collection
        @collection.map { |record| User.new(record) }
      end
    end
  end
end
