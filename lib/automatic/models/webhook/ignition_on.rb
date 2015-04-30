require File.expand_path('../../location', __FILE__)
require File.expand_path('../user', __FILE__)
require File.expand_path('../vehicle', __FILE__)

module Automatic
  module Models
    module Webhook
      class IgnitionOn
        # Builds an instance of the IgnitionOn webhook event
        #
        # @param attributes [Hash]
        #
        # @return [Automatic::Models::Webhook::IgnitionOn]
        def initialize(attributes={})
          @attributes = attributes
        end

        # Returns the ID of the event
        #
        # @return [String]
        def id
          @attributes['id']
        end

        # Returns the type of the event.
        #
        # @return [String]
        def type
          @attributes['type']
        end

        # Returns an instance of the core Location model
        #
        # @return [Automatic::Models::Location]
        def location
          Automatic::Models::Location.new(@attributes.fetch('location', {}))
        end

        # Returns an instance of the Webhook User model
        #
        # @return [Automatic::Models::Webhook::User]
        def user
          Automatic::Models::Webhook::User.new(@attributes.fetch('user', {}))
        end

        # Returns an instance of the Webhook Vehicle model
        #
        # @return [Automatic::Models::Webhook::Vehicle]
        def vehicle
          Automatic::Models::Webhook::Vehicle.new(@attributes.fetch('vehicle', {}))
        end

        # Returns the timezone of the event
        #
        # @return [String]
        def time_zone
          @attributes['time_zone']
        end
        alias :timezone :time_zone

        # Returns the UNIX timestamp of the event
        #
        # @note We want to always work with time objects
        # for consistency. We provide access to both, but
        # methods ending with `_at` should be Time objects.
        #
        # @return [Integer] UNIX timestamp
        def unix_created_at
          @attributes['created_at'].to_i
        end

        # Returns the date the event happened in
        # the timezone.
        #
        # @return [Time]
        def created_at
          created_at_before_zone.in_time_zone(self.time_zone)
        end

        private
        def created_at_before_zone
          begin
            Time.at(self.unix_created_at)
          rescue
            nil
          end
        end
      end
    end
  end
end
