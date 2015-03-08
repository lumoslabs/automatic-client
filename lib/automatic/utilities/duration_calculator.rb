module Automatic
  module Utilities
    class DurationCalculator
      def initialize(seconds)
        @seconds = seconds
      end

      def days
        parsed[0]
      end

      def days?
        self.days > 0
      end

      def hours
        parsed[1]
      end

      def hours?
        if self.hours == 0 && (self.days?)
          true
        else
          self.hours > 0
        end
      end

      def minutes
        parsed[2]
      end

      def minutes?
        if self.minutes == 0 && (self.hours? || self.days?)
          true
        else
          self.minutes > 0
        end
      end

      def seconds
        parsed[3]
      end

      def seconds?
        self.seconds > 0
      end

      def to_s
        str = []

        if self.days?
          str << [("%s days" % [self.days])]
        end

        if self.hours?
          str << [("%s hours" % [self.hours])]
        end

        if self.minutes?
          str << [("%s minutes" % [self.minutes])]
        end

        if self.seconds? && !self.minutes?
          str << [("%s seconds" % [self.seconds])]
        end

        str.join(' ')
      end

      private
      def parsed
        return @parsed if @parsed
        days,hours,minutes,seconds = [60,60,24].reduce([@seconds]) { |m,o| m.unshift(m.shift.divmod(o)).flatten }

        @parsed = [days, hours, minutes, seconds]
        @parsed
      end
    end
  end
end
