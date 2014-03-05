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
      def in_zone(timezone = 'UTC')
        zone_object = TZInfo::Timezone.get(timezone)
        time_period = zone_object.period_for_utc(self)
        (self + time_period.utc_offset)
      end
    end
  end
end
