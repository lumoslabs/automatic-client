module Automatic
  module Models
    class Models
      include Enumerable

      RecordNotFoundError = Class.new(StandardError)

      attr_reader :api_client

      def initialize(api_client = Automatic::Client)
        @api_client = api_client
      end

      def self.method_missing(method_sym, *arguments, &block)
        super unless method_defined?(method_sym)

        self.new.send(method_sym, *arguments, &block)
      end

      def self.respond_to_missing?(method_sym, include_private = false)
        method_defined?(method_sym) || super
      end

      # Find a Model by the specified ID
      #
      # @param id [String] The Automatic Model ID
      # @param options [Hash] HTTP Query String Parameters
      #
      # @raise [RecordNotFoundError] if no Model can be found
      #
      # @return [Automatic::Models::Model]
      def find_by_id!(id, options={})
        model = find_by_id(id, options)
        name = self.class.name.demodulize

        raise RecordNotFoundError.new("Could not find #{name} with ID %s" % [id]) if model.nil?

        model
      end

      # Find a Model by the specified ID
      #
      # @param id [String] The Automatic Model ID
      # @param options [Hash] HTTP Query String Parameters
      #
      # @return [Automatic::Models::Vehicle,Nil]
      def find_by_id(id, options={})
        name = self.class.name.demodulize.downcase
        route = Automatic::Client.routes.route_for(name)
        url   = route.url_for(id: id)

        request = api_client.get(url, options)

        if request.success?
          self.class::INDIVIDUAL_MODEL.new(request.body)
        else
          nil
        end
      end

      # Return self with collection. By default we will stream until we have all
      # instances of the model. You can set `per_page` and `page` in the
      # request.
      #
      # @param options [Hash] Options to send to the HTTP request.
      #
      # @return [Automatic::Models::Models] Automatic Models
      def all(options={})
        @collection = query(options)
        self
      end

      # Make a connection to Automatic to retrieve model.
      #
      # @param options [Hash] Options to send to the HTTP Request
      #
      # @return [Array] JSON representation of specified model
      def query(options = {})
        paginate = if options.has_key?(:paginate)
                     options.delete(:paginate)
                   else
                     true
                   end

        name = self.class.name.demodulize.downcase
        route = Automatic::Client.routes.route_for(name)
        url   = route.url_for

        request = api_client.get(url, options)

        if request.success?
          raw_results = []

          metadata    = Automatic::Models::Response::Metadata.new(request.body.fetch('_metadata', {}))
          link_header = Automatic::Models::Response::LinkHeader.new(request.headers['Link'])
          links       = link_header.links

          raw_results.concat(request.body.fetch('results', []))

          if links.next? && paginate
            loop do
              request = api_client.get(links.next.uri)

              link_header = Automatic::Models::Response::LinkHeader.new(request.headers['Link'])
              links       = link_header.links

              raw_results.concat(request.body.fetch('results', []))

              break unless links.next?
            end
          end

          raw_results
        else
          raise StandardError.new(request.body)
        end
      end

      # Method needed for Enumerable support
      #
      # @return [Array, Models] A collection of Model objects
      def each(&block)
        internal_collection.each(&block)
      end

      private

      def internal_collection
        (@collection || query).map { |record| self.class::INDIVIDUAL_MODEL.new(record) }
      end
    end
  end
end
