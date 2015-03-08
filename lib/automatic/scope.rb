module Automatic
  class Scope
    def initialize(attributes={})
      @attributes = attributes
    end

    def name
      @attributes.fetch('name', nil)
    end

    def description
      @attributes.fetch('description', nil)
    end

    def extra
      @attributes.fetch('extra', nil)
    end
  end
end
