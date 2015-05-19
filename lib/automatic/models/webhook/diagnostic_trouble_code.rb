module Automatic
  module Models
    module Webhook
      class DiagnosticTroubleCode
        # Build an instance of the DiagnosticTroubleCode domain model
        #
        # @note This is a mixture of the DiagnosticTroubleCode and Webhook
        # event (includes date). This is not currently used anywhere else, so
        # we do not yet have a core DiagnosticTroubleCode model
        #
        # @param attributes [Hash]
        #
        # @return [Automatic::Models::Webhook::DiagnosticTroubleCode]
        def initialize(attributes={})
          @attributes = attributes
        end

        # Returns the code
        #
        # @return [String]
        def code
          @attributes['code']
        end

        # Returns the description of the dtcs
        #
        # @return [String]
        def description
          @attributes['description']
        end

        # Returns the provided UNIX timestamp in milliseconds
        #
        # @return [Integer] UNIX timestamp
        def unix_started_at
          @attributes['start'].to_i
        end

        # Returns the UTC Timestamp of the time the code happened
        #
        # We don't have Timezone information here, so we will return
        # it as UTC and leave it to the calling object to cast to the
        # corresponding Timezone. The root Webhook Event includes the
        # timezone.
        #
        # @return [Time]
        def started_at
          begin
            Time.at(unix_started_at_seconds).utc
          rescue
            nil
          end
        end

        private
        def unix_started_at_seconds
          (self.unix_started_at / 1000)
        end
      end
    end
  end
end
