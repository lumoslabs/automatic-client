require 'faraday_middleware'
require 'delegate'

module Automatic
  class Connection < SimpleDelegator

    def initialize(url, &block)
      @_connection = Faraday.new(url, &block)
    end

    def __getobj__
      @_connection
    end
  end
end
