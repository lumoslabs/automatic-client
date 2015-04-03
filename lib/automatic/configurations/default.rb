require 'logger'

module Automatic
  module Configurations
    # This module is designated to setting the default values
    # for the Client Configuration
    module Default
      API_HOST = "https://api.automatic.com".freeze

      RACK_BUILDER_CLASS = if defined?(Faraday::RackBuilder) then Faraday::RackBuilder else Faraday::Builder end

      MIDDLEWARE = RACK_BUILDER_CLASS.new do |builder|
        builder.adapter(Faraday.default_adapter)
      end

      USER_AGENT   = ("Automatic Ruby Gem %s" % [Automatic::Client::VERSION]).freeze
      MEDIA_TYPE   = "application/json"
      CONTENT_TYPE = "application/json"

      # Return a hash of default keys and values
      #
      # @return [Hash] Configuration keys and default values
      def self.options
        Hash[Automatic::Configuration.keys.map { |key| [key, __send__(key)] }]
      end

      # Returns the default access token
      #
      # @return [String,nil]
      def self.access_token
        ENV['AUTOMATIC_ACCESS_TOKEN']
      end

      # Returns the specified API host or the default
      # production domain.
      #
      # @return [String]
      def self.api_host
        ENV['AUTOMATIC_API_HOST'] || API_HOST
      end

      # Returns the specified media type or the default.
      #
      # @return [String]
      def self.media_type
        ENV['AUTOMATIC_MEDIA_TYPE'] || MEDIA_TYPE
      end

      # Returns the specified content type or the default.
      #
      # @return [String]
      def self.content_type
        ENV['AUTOMATIC_CONTENT_TYPE'] || CONTENT_TYPE
      end

      # Returns the specified User Agent or the default
      #
      # @return [String]
      def self.user_agent
        ENV['AUTOMATIC_USER_AGENT'] || USER_AGENT
      end

      # Returns the specified auto pagination or false
      #
      # @return [Boolean]
      def self.auto_paginate
        auto_paginate_value = ENV['AUTOMATIC_AUTO_PAGINATE']

        auto_paginate = case(auto_paginate_value)
                        when 'true'
                          true
                        when 'false'
                          false
                        when nil
                          false
                        else
                          auto_paginate_value
                        end

        auto_paginate
      end

      # Returns the default HTTP cache logger
      #
      # @note This is only applicable if caching is enabled
      #
      # @return [Logger] Log to STDOUT
      def self.cache_logger
        Logger.new(STDOUT)
      end

      # Returns the default HTTP request logger
      #
      # @return [Logger] Log to STDOUT
      def self.request_logger
        Logger.new(STDOUT)
      end

      # Return the default Gem Application Logger
      #
      # @return [Logger] Log to STDOUT
      def self.application_logger
        Logger.new(STDOUT)
      end

      # Return the default middleware stack
      #
      # @return [Faraday::RackBuilder] Faraday Rack Builder
      def self.middleware
        MIDDLEWARE
      end

      # Return the default set of connection options
      #
      # @return [Hash]
      def self.connection_options
        {
          :headers => {
            :accept       => self.media_type,
            :user_agent   => self.user_agent,
            :content_type => self.content_type
          }
        }
      end
    end
  end
end
