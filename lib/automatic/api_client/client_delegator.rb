module Automatic
  class ApiClient
    class ClientDelegator
      attr_reader :api_client, :delegated_class

      def initialize(api_client, delegated_class)
        @api_client = api_client
        @delegated_class = delegated_class
      end

      def method_missing(method_sym, *arguments, &block)
        super unless delegated_class.respond_to?(method_sym)

        arguments[1 + delegated_class.method(method_sym).arity] ||= {}
        arguments.last.merge!(client: api_client)

        delegated_class.send(method_sym, *arguments, &block)
      end
    end
  end
end
