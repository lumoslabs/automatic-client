module Automatic
  module Models
    module Webhook
      class Button
        # Creates a new instance of the Button model used
        # in the HMI Interaction Webhook Event
        #
        # @param attributes [Hash]
        #
        # @return [Automatic::Models::Webhook::Button]
        def initialize(attributes={})
          @attributes = attributes
        end

        # Return the ID
        #
        # @return [String]
        def id
          @attributes['id']
        end
      end
    end
  end
end
