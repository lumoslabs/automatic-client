require File.expand_path('../error', __FILE__)

module Automatic
  class Errors
    include Enumerable

    def initialize(collection)
      @collection = Array(collection)
    end

    def each(&block)
      record_collection.each(&block)
    end

    def find_by_code(code)
      self.select { |record| record.code == code.to_i }.first
    end

    def find_by_name(name)
      self.select { |record| record.name == name.to_s }.first
    end

    private
    def record_collection
      @collection.map { |record| Error.new(record) }
    end
  end
end
