require File.expand_path('../../location', __FILE__)
require File.expand_path('../user', __FILE__)
require File.expand_path('../vehicle', __FILE__)
require File.expand_path('../diagnostic_trouble_codes', __FILE__)

module Automatic
  module Models
    module Webhook
      class MilOff
        # Builds an instance of the MilOff webhook event
        #
        # @param attributes [Hash]
        #
        # @return [Automatic::Models::Webhook::MilOff]
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

        # Returns an instance of the Webhook DiagnosticTroubleCodes
        # collection model
        #
        # @return [Automatic::Models::Webhook::DiagnosticTroubleCodes]
        def dtcs
          Automatic::Models::Webhook::DiagnosticTroubleCodes.new(@attributes.fetch('dtcs', []))
        end
        alias :diagnostic_trouble_codes :dtcs

        # Returns true if the MIL event was cleared by the user
        #
        # @return [Boolean]
        def user_cleared
          @attributes['user_cleared']
        end
        alias :user_cleared? :user_cleared


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
