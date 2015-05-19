module Automatic
  module Models
    class Users
      include Enumerable

      RecordNotFoundError = Class.new(StandardError)

      # Find a User by the specified ID
      #
      # @param id [String] The Automatic User ID
      # @param options [Hash] HTTP Query String Parameters
      #
      # @return [Automatic::Models::User,Nil]
      def self.find_by_id(id, options={})
        user_route = Automatic::Client.routes.route_for('user')
        user_url   = user_route.url_for(id: id)

        request = Automatic::Client.get(user_url, options)

        if request.success?
          Automatic::Models::User.new(request.body)
        else
          nil
        end
      end

      # Find a User by the specified ID
      #
      # @param id [String] The Automatic User ID
      # @param options [Hash] HTTP Query String Parameters
      #
      # @raise [RecordNotFoundError] if no User can be found
      #
      # @return [Automatic::Models::User] Automatic User Model
      def self.find_by_id!(id, options={})
        user = self.find_by_id(id, options)

        raise RecordNotFoundError.new("Could not find User with ID %s" % [id]) if user.nil?

        user
      end

      # Create a new Users instance
      #
      # @param collection [Array] A collection of User Definitions
      #
      # @return [Automatic::Client::Users]
      def initialize(collection)
        @collection = Array(collection)
      end

      # Enable Enumerable support
      #
      # @return [Automatic::Models::Users] A collection of users
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
