module Automatic
  class Routes
    # Create a new instance of a Route collection. This
    # allows us to keep all endpoints in a single object and
    # then later retrieve them by name.
    #
    # @example
    #   routes = Automatic::Routes.new
    #   routes.add_route(Automatic::Route.new('trips', 'http://api.example.com/trips'))
    #
    #   routes.route_for('trips')
    #   => #<Automatic::Route:0x00000101e24990 @name="trips", @path="http://api.example.com/trips", @options={:templated=>false}>
    #
    def initialize
      @routes = []
    end

    # Add a route to the collection
    #
    # @return [Array] Routes collection
    def add_route(route)
      @routes << route
    end

    # Returns the route by name
    #
    # @return [Route, nil] Instance of the route by name or nil
    def route_for(name)
      name = name.to_s
      @routes.select { |record| record.name == name }.first
    end

    # Returns the collection of routes
    #
    # @return [Array] Routes
    def routes
      @routes
    end

    # Returns true if there are any routes
    #
    # @return [Boolean] True if routes exist
    def routes?
      @routes.any?
    end
  end
end
