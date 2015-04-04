require 'tzinfo'

module Automatic
  module CoreExtension
    module Time
      def from_milliseconds
        ::Time.at(self.to_i / 1000)
      end

      # Returns the time in the specififed Timezone. If none
      # is provided it will use UTC
      #
      # @return [Time] The Time in the corresponding zone
      def in_zone(timezone=nil)
        timezone = if (timezone.nil? || timezone.empty?) then 'UTC' else timezone end

        zone_object = TZInfo::Timezone.get(timezone)
        time_period = zone_object.period_for_utc(self)
        zone_object.utc_to_local(self)
      end
    end
  end
end
