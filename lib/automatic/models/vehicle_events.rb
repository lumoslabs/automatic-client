require 'ostruct'

module Automatic
  module Models
    class VehicleEvents
      include Enumerable

      # Return a polymorphic collection of Automatic Event domain models
      #
      # @param collection [Array] Array of JSON Automatic Event models
      #
      # @return [Automatic::Models::VehicleEvents]
      def initialize(collection)
        @collection = Array(collection)
      end

      # Implement #each for Enumerable support
      #
      # @return [Array]
      def each(&block)
        records_collection.each(&block)
      end

      # Return all events of the specified type
      #
      # @note Return `self` so we can chain information.
      #
      # @return [Array]
      def find_all_by_type(type)
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
