require 'logger'

module Automatic
  module Configurations
    module Default
      API_HOST = "https://api.automatic.com".freeze

      RACK_BUILDER_CLASS = if defined?(Faraday::RackBuilder) then Faraday::RackBuilder else Faraday::Builder end

      MIDDLEWARE = RACK_BUILDER_CLASS.new do |builder|
        builder.adapter(Faraday.default_adapter)
      end

      USER_AGENT   = ("Automatic Ruby Gem %s" % [Automatic::Client::VERSION]).freeze
      MEDIA_TYPE   = "application/json"
      CONTENT_TYPE = "application/json"

      def self.options
        Hash[Automatic::Configuration.keys.map { |key| [key, __send__(key)] }]
      end

      def self.access_token
        ENV['AUTOMATIC_ACCESS_TOKEN']
      end

      def self.api_host
        ENV['AUTOMATIC_API_HOST'] || API_HOST
      end

      def self.media_type
        ENV['AUTOMATIC_MEDIA_TYPE'] || MEDIA_TYPE
      end

      def self.content_type
        ENV['AUTOMATIC_CONTENT_TYPE'] || CONTENT_TYPE
      end

      def self.user_agent
        ENV['AUTOMATIC_USER_AGENT'] || USER_AGENT
      end

      def self.auto_paginate
        auto_paginate_value = ENV['AUTOMATIC_AUTO_PAGINATE']

        auto_paginate = case(auto_paginate_value)
                        when 'true'
                          true
                        when 'false'
                          false
                        else
                          auto_paginate_value
                        end


        auto_paginate
      end

      def self.cache_logger
        Logger.new(STDOUT)
      end

      def self.request_logger
        Logger.new(STDOUT)
      end

      def self.application_logger
        Logger.new(STDOUT)
      end

      def self.middleware
        MIDDLEWARE
      end

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
