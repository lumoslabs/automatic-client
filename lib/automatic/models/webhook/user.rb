module Automatic
  module Models
    module Webhook
      class User
        # Create an instance of a Webhook User
        #
        # @note This is a webhook User model. Once
        # this is unified with the core User model
        # we can remove this.
        #
        # @param attributes [Hash] User attributes
        #
        # @return [Automatic::Models::Webhook::User]
        def initialize(attributes={})
          @attributes = attributes
        end

        # Returns the ID of the User
        #
        # @deprecated use {#v2_id} instead
        #
        # @return [String] Automatic ID
        def id
          @attributes['id']
        end

        # Returns the V2 ID of the User
        #
        # @return [String]
        def v2_id
          @attributes['v2_id']
        end
      end
    end
  end
end
