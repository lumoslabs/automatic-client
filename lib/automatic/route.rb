require 'addressable/template'

module Automatic
  class Route
    # Create a new Route that can be used to
    # issue requests against
    #
    def initialize(name, path, options={})
      @name = name
      @path = path

      @options = default_options.merge(options)
    end

    # Returns the name of the Route itself
    #
    # @return [String]
    def name
      @name
    end

    # Returns the URL for the route
    #
    # @return [String] The templated or base URI
    def url_for(options={})
      if templated?
        template = Addressable::Template.new(@path)
        template = template.expand(options)
        template.to_s
      else
        @path
      end
    end

    private
    def default_options
      {
        :templated => false
      }
    end

    def templated?
      @options.fetch(:templated, false)
    end
  end
end
