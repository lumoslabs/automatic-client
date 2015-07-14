require 'automatic/models/trip'

module Automatic
  module Models
    class Trips < Models
      INDIVIDUAL_MODEL = Trip

      # Return all trips taken today
      #
      # @param options [Hash] HTTP request options
      #
      # @return [Automatic::Models::Trips] Automatic Trips Model
      def today(options={})
        today = Time.now

        between(today.beginning_of_day.to_i, today.end_of_day.to_i, options)
      end

      # Return all trips taken yesterday
      #
      # @param options [Hash] HTTP request options
      #
      # @note This is an experiment to utilize ActiveSupport Date/Time extensions to
      # provide quick access to specific sets of trips.
      #
      # @return [Automatic::Models::Trips] Automatic Trips Model
      def yesterday(options={})
        yesterday = Time.now.yesterday

        between(yesterday.beginning_of_day.to_i, yesterday.end_of_day.to_i, options)
      end

      # Return all trips for this week
      #
      # @param options [Hash] HTTP request options
      #
      # @return [Automatic::Models::Trips] Automatic Trips Model
      def this_week(options={})
        today     = Time.now
        this_week = today.beginning_of_week

        between(this_week.beginning_of_day.to_i, today.end_of_day.to_i, options)
      end
      alias :this_week_to_date :this_week

      # Return all trips for last week
      #
      # @param options [Hash] HTTP request options
      #
      # @return [Automatic::Models::Trips] Automatic Trips Model
      def last_week(options={})
        today     = Time.now
        last_week = today.last_week

        between(last_week.beginning_of_week.to_i, last_week.end_of_week.to_i, options)
      end

      # Return all trips for last week to current date
      #
      # @param options [Hash] HTTP request options
      #
      # @return [Automatic::Models::Trips] Automatic Trips Model
      def last_week_to_date(options={})
        today     = Time.now
        last_week = today.last_week

        between(last_week.beginning_of_week.to_i, (today - 1.week).to_i, options)
      end

      # Return all trips for this month
      #
      # @param options [Hash] HTTP request options
      #
      # @return [Automatic::Models::Trips] Automatic Trips Model
      def this_month(options={})
        today      = Time.now
        this_month = today.beginning_of_month

        between(this_month.beginning_of_day.to_i, today.end_of_day.to_i, options)
      end
      alias :this_month_to_date :this_month

      # Return all trips for last month
      #
      # @param options [Hash] HTTP request options
      #
      # @return [Automatic::Models::Trips] Automatic Trips Model
      def last_month(options={})
        today      = Time.now
        last_month = today.last_month

        between(last_month.beginning_of_month.to_i, last_month.end_of_month.to_i, options)
      end

      # Return all trips for last month to date
      #
      # @param options [Hash] HTTP request options
      #
      # @return [Automatic::Models::Trips] Automatic Trips Model
      def last_month_to_date(options={})
        today      = Time.now
        last_month = today.last_month

        between(last_month.beginning_of_month.to_i, last_month.to_i, options)
      end

      # Return all trips for this year
      #
      # @param options [Hash] HTTP request options
      #
      # @return [Automatic::Models::Trips] Automatic Trips Model
      def this_year(options={})
        today     = Time.now
        this_year = today.beginning_of_year

        between(this_year.to_i, today.end_of_day.to_i, options)
      end
      alias :this_year_to_date :this_year

      # Return all trips for last year
      #
      # @param options [Hash] HTTP request options
      #
      # @return [Automatic::Models::Trips] Automatic Trips Model
      def last_year(options={})
        today     = Time.now
        last_year = today.last_year

        between(last_year.beginning_of_year.to_i, last_year.end_of_year.to_i, options)
      end

      # Return all trips for last year to date
      #
      # @param options [Hash] HTTP request options
      #
      # @return [Automatic::Models::Trips] Automatic Trips Model
      def last_year_to_date(options={})
        today     = Time.now
        last_year = today.last_year

        between(last_year.beginning_of_year.to_i, last_year.to_i, options)
      end

      # Core helper method to get trips between time range
      #
      # @param start_timestamp [Integer] UNIX Timestamp
      # @param end_timestamp [Integer] UNIX Timestamp
      # @param options [Hash] Additional Request options
      #
      # @return [Automatic::Models::Trips] Automatic Trips Model
      def between(start_timestamp, end_timestamp, options={})
        request_params = {
          :started_at__gte => start_timestamp.to_i,
          :started_at__lte => end_timestamp.to_i
        }

        request_options = options.merge!(request_params)

        all(request_options)
      end

      # Out of this collection, find all trips with a Tagging
      # of business
      #
      # @return [Array]
      def business
        self.select(&:business?)
      end

      # Return true if there are any business related trips
      # in this collection.
      #
      # @return [Boolean]
      def business?
        self.business.any?
      end

      # -- STATISTICS
      # TODO: Move the below to statistics helpers

      # Return the total miles for the trips
      # in the collection
      #
      # @return [Float]
      def total_miles
        self.inject(0) do |accum,trip|
          accum += trip.distance_in_miles
          accum
        end
      end

      # Return the total fuel cost for the trips
      # in the collection.
      #
      # @return [Float]
      def total_fuel_cost
        self.inject(0) do |accum,trip|
          accum += trip.fuel_cost_usd
          accum
        end
      end

      # Return the total fuel in gallons for the trips
      # in the collection.
      #
      # @return [Float]
      def total_fuel_gallons
        self.inject(0) do |accum,trip|
          accum += trip.fuel_volume_gal
          accum
        end
      end

      # Returns the overall MPG for the trips
      # in the collection.
      #
      # @return [Float]
      def total_mpg
        if self.total_miles > 0
          (self.total_miles / self.total_fuel_gallons)
        else
          0
        end
      end

      # Returns the total hard brake counter cache
      # for the trips in the collection.
      #
      # @return [Integer]
      def total_hard_brakes
        self.inject(0) do |accum,trip|
          accum += trip.hard_brakes_count
          accum
        end
      end

      # Returns the total hard accels counter cache
      # for the trips in the collection.
      #
      # @return [Integer]
      def total_hard_accels
        self.inject(0) do |accum,trip|
          accum += trip.hard_accels_count
          accum
        end
      end

      # Returns the total idling time for the trips
      # in the collection.
      #
      # @return [Integer]
      def total_idling_time
        self.inject(0) do |accum,trip|
          accum += trip.idling_time
          accum
        end
      end

      # Returns the average idling time for the trips
      # in the collection.
      #
      # @return [Float]
      def average_idling_time
        if self.total_duration > 0
          ((self.total_idling_time / self.total_duration) * 100)
        else
          0
        end
      end

      # Return the total driving time for the trips
      # in the collection.
      #
      # @return [Integer]
      def total_driving_time
        (self.total_duration - self.total_idling_time)
      end

      # Returns the average driving time for the trips
      # in the collection.
      #
      # @return [Float]
      def average_driving_time
        if self.total_duration > 0
          ((self.total_driving_time / self.total_duration) * 100)
        else
          0
        end
      end

      # Returns the total duration over 70 for the
      # trips in the collection.
      #
      # @return [Float]
      def total_duration_over_70
        self.inject(0) do |accum,trip|
          accum += trip.duration_over_70
          accum
        end
      end

      # Returns the total duration for the trips
      # in the collection
      #
      # @return [Float]
      def total_duration
        self.inject(0) do |accum,trip|
          accum += trip.duration
          accum
        end
      end
      # -- STATISTICS
    end
  end
end
