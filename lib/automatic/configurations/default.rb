module Automatic
  module Configurations
    module Default
      API_HOST = "https://api.automatic.com".freeze

      RACK_BUILDER_CLASS = if defined?(Faraday::RackBuilder) then Faraday::RackBuilder else Faraday::Builder end

      MIDDLEWARE = RACK_BUILDER_CLASS.new do |builder|
        builder.adapter(Faraday.default_adapter)
      end

      USER_AGENT = ("Automatic Ruby Gem %s" % [Automatic::Client::VERSION]).freeze
      MEDIA_TYPE = "application/json"

      def self.options
        Hash[Automatic::Configuration.keys.map { |key| [key, __send__(key)] }]
      end

      def self.access_token
        ENV['AUTOMATIC_ACCESS_TOKEN']
      end

      def self.api_host
        ENV['AUTOMATIC_API_HOST'] || API_HOST
      end

      # NOTE: We want to provide convenience headers here as well, for `accept`
      # and `content_type`
      def self.media_type
        ENV['AUTOMATIC_MEDIA_TYPE'] || MEDIA_TYPE
      end

      def self.user_agent
        ENV['AUTOMATIC_USER_AGENT'] || USER_AGENT
      end

      def self.auto_paginate
        auto_paginate = ENV.fetch('AUTOMATIC_AUTO_PAGINATE', false)

        auto_paginate = if auto_paginate == 'true' then true end
        auto_paginate = if auto_paginate == 'false' then false end

        auto_paginate
      end

      # TODO: Ensure we have a Logger instance
      def self.cache_logger
        ENV['AUTOMATIC_CACHE_LOGGER']
      end

      # TODO: Ensure we have a Logger instance
      def self.request_logger
        ENV['AUTOMATIC_REQUEST_LOGGER']
      end

      def self.middleware
        MIDDLEWARE
      end

      def self.connection_options
        {
          :headers => {
            :accept     => self.media_type,
            :user_agent => self.user_agent
          }
        }
      end
    end
  end
end
