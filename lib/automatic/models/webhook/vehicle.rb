module Automatic
  module Models
    module Webhook
      class Vehicle
        # Builds an object for the Webhook Vehicle
        #
        # @note This is currently different than the core
        # Vehicle model. Once they are merged we can reference
        # the core models.
        #
        # @return [Automatic::Models::Webhook::Vehicle]
        def initialize(attributes={})
          @attributes = attributes
        end

        # Returns the ID of the vehicle
        #
        # @return [String]
        def id
          @attributes['id']
        end

        # It returns the vehicle display name
        #
        # This should be either the name or user
        # specified name from the app.
        #
        # @return [String]
        def display_name
          @attributes['display_name']
        end

        # Returns the year of the vehicle
        #
        # @return [Integer]
        def year
          @attributes['year'].to_i
        end

        # Returns the make of the vehicle
        #
        # @return [String]
        def make
          @attributes['make']
        end

        # Returns the model of the vehicle
        #
        # @return [String]
        def model
          @attributes['model']
        end

        # Returns the hex color of the vehicle
        #
        # @return [String] HEX color with hash
        def color
          @attributes['color']
        end
      end
    end
  end
end
