module Automatic
  module Models
    class Trips
      include Enumerable

      RecordNotFoundError = Class.new(StandardError)

      # Creates a new instance of the Trips Collection. This is
      # used to wrap the trips and allow extra support for finders,
      # sorting, and grouping
      #
      # @param collection [Array] A collection of Automatic Trip Definitions
      #
      # @return [Automatic::Models::Trips] Instance of the object
      def initialize(collection={})
        @collection = Array(collection)
      end

      # Return all trips taken today
      #
      # @param options [Hash] HTTP request options
      #
      # @return [Automatic::Models::Trips] Automatic Trips Model
      def self.today(options={})
        today = Time.now

        self.between(today.beginning_of_day.to_i, today.end_of_day.to_i, options)
      end

      # Return all trips taken yesterday
      #
      # @param options [Hash] HTTP request options
      #
      # @note This is an experiment to utilize ActiveSupport Date/Time extensions to
      # provide quick access to specific sets of trips.
      #
      # @return [Automatic::Models::Trips] Automatic Trips Model
      def self.yesterday(options={})
        yesterday = Time.now.yesterday

        self.between(yesterday.beginning_of_day.to_i, yesterday.end_of_day.to_i, options)
      end

      # Return all trips for this week
      #
      # @param options [Hash] HTTP request options
      #
      # @return [Automatic::Models::Trips] Automatic Trips Model
      def self.this_week(options={})
        today     = Time.now
        this_week = today.beginning_of_week

        self.between(this_week.beginning_of_day.to_i, today.end_of_day.to_i, options)
      end
      class << self; alias :this_week_to_date :this_week; end

      # Return all trips for last week
      #
      # @param options [Hash] HTTP request options
      #
      # @return [Automatic::Models::Trips] Automatic Trips Model
      def self.last_week(options={})
        today     = Time.now
        last_week = today.last_week

        self.between(last_week.beginning_of_week.to_i, last_week.end_of_week.to_i, options)
      end

      # Return all trips for last week to current date
      #
      # @param options [Hash] HTTP request options
      #
      # @return [Automatic::Models::Trips] Automatic Trips Model
      def self.last_week_to_date(options={})
        today     = Time.now
        last_week = today.last_week

        self.between(last_week.beginning_of_week.to_i, (today - 1.week).to_i, options)
      end

      # Return all trips for this month
      #
      # @param options [Hash] HTTP request options
      #
      # @return [Automatic::Models::Trips] Automatic Trips Model
      def self.this_month(options={})
        today      = Time.now
        this_month = today.beginning_of_month

        self.between(this_month.beginning_of_day.to_i, today.end_of_day.to_i, options)
      end
      class << self; alias :this_month_to_date :this_month; end

      # Return all trips for last month
      #
      # @param options [Hash] HTTP request options
      #
      # @return [Automatic::Models::Trips] Automatic Trips Model
      def self.last_month(options={})
        today      = Time.now
        last_month = today.last_month

        self.between(last_month.beginning_of_month.to_i, last_month.end_of_month.to_i, options)
      end

      # Return all trips for last month to date
      #
      # @param options [Hash] HTTP request options
      #
      # @return [Automatic::Models::Trips] Automatic Trips Model
      def self.last_month_to_date(options={})
        today      = Time.now
        last_month = today.last_month

        self.between(last_month.beginning_of_month.to_i, last_month.to_i, options)
      end

      # Return all trips for this year
      #
      # @param options [Hash] HTTP request options
      #
      # @return [Automatic::Models::Trips] Automatic Trips Model
      def self.this_year(options={})
        today     = Time.now
        this_year = today.beginning_of_year

        self.between(this_year.to_i, today.end_of_day.to_i, options)
      end
      class << self; alias :this_year_to_date :this_year; end

      # Return all trips for last year
      #
      # @param options [Hash] HTTP request options
      #
      # @return [Automatic::Models::Trips] Automatic Trips Model
      def self.last_year(options={})
        today     = Time.now
        last_year = today.last_year

        self.between(last_year.beginning_of_year.to_i, last_year.end_of_year.to_i, options)
      end

      # Return all trips for last year to date
      #
      # @param options [Hash] HTTP request options
      #
      # @return [Automatic::Models::Trips] Automatic Trips Model
      def self.last_year_to_date(options={})
        today     = Time.now
        last_year = today.last_year

        self.between(last_year.beginning_of_year.to_i, last_year.to_i, options)
      end

      # Core helper method to get trips between time range
      #
      # @param start_timestamp [Integer] UNIX Timestamp
      # @param end_timestamp [Integer] UNIX Timestamp
      # @param options [Hash] Additional Request options
      #
      # @return [Automatic::Models::Trips] Automatic Trips Model
      def self.between(start_timestamp, end_timestamp, options={})
        request_params = {
          :started_at__gte => start_timestamp.to_i,
          :started_at__lte => end_timestamp.to_i
        }

        request_options = options.merge!(request_params)

        self.all(request_options)
      end

      # Find a Trip by the specified ID
      #
      # @param id [String] The Automatic Trip ID
      # @param options [Hash] HTTP Query String Parameters
      #
      # @raise [RecordNotFoundError] if no Trip can be found
      #
      # @return [Automatic::Models::Trip] Automatic Trip Model
      def self.find_by_id!(id, options={})
        trip = self.find_by_id(id, options)

        raise RecordNotFoundError.new("Could not find Trip with ID %s" % [id]) if trip.nil?

        trip
      end

      # Find a Trip by the specified ID
      #
      # @param id [String] The Automatic Trip ID
      # @param options [Hash] HTTP Query String Parameters
      #
      # @return [Automatic::Models::Trip,Nil]
      def self.find_by_id(id, options={})
        trip_route = Automatic::Client.routes.route_for('trip')
        trip_url   = trip_route.url_for(id: id)

        request = Automatic::Client.get(trip_url, options)

        if request.success?
          Automatic::Models::Trip.new(request.body)
        else
          nil
        end
      end

      # Make a connection to Automatic to retrieve all trips. By default
      # we will stream until we have all trips. You can set `per_page` and `page` in the request.
      #
      # @param options [Hash] Options to send to the HTTP request.
      #
      # @return [Automatic::Model::Trips] Automatic Trips Model
      def self.all(options={})
        paginate = if options.has_key?(:paginate)
                     options.delete(:paginate)
                   else
                     true
                   end

        trips_route = Automatic::Client.routes.route_for('trips')
        trips_url   = trips_route.url_for

        request = Automatic::Client.get(trips_url, options)

        if request.success?
          raw_trips = []

          link_header = Automatic::Models::Response::LinkHeader.new(request.headers['Link'])
          links       = link_header.links

          raw_trips.concat(request.body.fetch('results', []))

          if links.next? && paginate
            loop do
              request = Automatic::Client.get(links.next.uri)

              link_header = Automatic::Models::Response::LinkHeader.new(request.headers['Link'])
              links       = link_header.links

              raw_trips.concat(request.body.fetch('results', []))

              break unless links.next?
            end
          end

          self.new(raw_trips)
        else
          raise StandardError.new(request.body)
        end
      end

      # Method needed for Enumerable support
      #
      # @return [Array, Trips] A collection of Trip objects
      def each(&block)
        internal_collection.each(&block)
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

      private
      def internal_collection
        @collection.map { |record| Trip.new(record) }
      end
    end
  end
end
