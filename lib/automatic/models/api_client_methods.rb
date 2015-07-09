module Automatic
  module Models
    module ApiClientMethods
      def api_client(options)
        options.has_key?(:client) ? options.delete(:client) : Automatic::Client
      end
    end
  end
end
