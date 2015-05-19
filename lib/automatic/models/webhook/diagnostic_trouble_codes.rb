require File.expand_path('../diagnostic_trouble_code', __FILE__)

module Automatic
  module Models
    module Webhook
      class DiagnosticTroubleCodes
        include Enumerable

        # Return an instance of th DiagnosticTroubleCodes domain model
        #
        # This is scoped to the Webhook events themselves and includes the
        # date in the returning model. This is not currently used anywhere else, so we
        # do not yet have a core DiagnosticTroubleCodes model
        #
        # @param collection [Array]
        #
        # @return [Automatic::Models::Webhook::DiagnosticTroubleCodes]
        def initialize(collection)
          @collection = Array(collection)
        end

        # Implement Enumerable
        def each(&block)
          internal_collection.each(&block)
        end

        private
        def internal_collection
          @collection.map { |record| DiagnosticTroubleCode.new(record) }
        end
      end
    end
  end
end
