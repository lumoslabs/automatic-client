require 'ostruct'

module Automatic
  module Models
    class VehicleEvents
      include Enumerable

      def initialize(collection)
        @collection = Array(collection)
      end

      def each(&block)
        records_collection.each(&block)
      end

      def find_all_by_type(type)
        # NOTE: Return an instance of self
        self.select { |record| record.type == type.to_s }
      end

      private
      def records_collection
        @collection.map do |record|
          # NOTE - Use a class map
          case(record['type'])
          when 'speeding'
            Automatic::Models::VehicleEvent::NotificationSpeeding.new(record)
          when 'hard_accel'
            Automatic::Models::VehicleEvent::NotificationHardAccel.new(record)
          when 'hard_brake'
            Automatic::Models::VehicleEvent::NotificationHardBrake.new(record)
          else
            OpenStruct.new(record)
          end
        end
      end
    end
  end
end
