require File.expand_path('../configurations', __FILE__)

module Automatic
  class Configuration
    # Connection
    attr_accessor :api_host
    attr_accessor :access_token
    attr_accessor :connection_options
    attr_accessor :middleware

    # Request
    attr_accessor :user_agent
    attr_accessor :media_type
    attr_accessor :content_type

    # Pagination
    attr_accessor :auto_paginate

    # Logging
    attr_accessor :cache_logger
    attr_accessor :request_logger

    def self.keys
      @keys ||= [
        :api_host,
        :access_token,
        :connection_options,
        :middleware,
        :user_agent,
        :content_type,
        :media_type,
        :auto_paginate,
        :cache_logger,
        :request_logger
      ]
    end

    def initialize(attributes={})
      # Setup with either the attributes provided or fall back to the default
      self.class.keys.each do |key|
        instance_variable_set(:"@#{key}", (attributes[key] || Automatic::Configurations::Default.options[key]))
      end
    end

    def configure(&block)
      yield(self)
    end

    def reset!
      self.class.keys.each do |key|
        instance_variable_set(:"@#{key}", Automatic::Configurations::Default.options[key])
      end
      self
    end
    alias :setup :reset!

    def request_logger?
      !self.request_logger.nil?
    end

    def cache_logger?
      !self.cache_logger.nil?
    end
  end
end
