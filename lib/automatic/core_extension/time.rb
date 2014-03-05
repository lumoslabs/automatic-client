require 'tzinfo'

module Automatic
  module CoreExtension
    module Time
      def from_milliseconds
        ::Time.at(self.to_i / 1000)
      end

      def in_zone(timezone)
        return nil if (timezone.nil? || timezone.empty?)

        zone_object = TZInfo::Timezone.get(timezone)
        time_period = zone_object.period_for_utc(self)
        (self + time_period.utc_offset)
      end
    end
  end
end
