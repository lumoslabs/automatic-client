require 'csv'
require 'thor'
require 'terminal-table'

require File.expand_path('../../client', __FILE__)

module Automatic
  module CommandLine
    class Trips < Thor
      desc 'export', 'Export Automatic Trips to CSV'
      option :filename, type: :string, banner: 'trips-{timestamp}.csv', default: nil
      def export
        trips = Automatic::Client::Trips.all

        if trips.any?
          default_filename = "trips-%s.csv" % [Time.now.utc.to_i]

          filename = (options[:filename] || default_filename)

          trip_row = ->(record) do
            [record.id, record.vehicle.display_name, record.start_location.lat, record.start_location.lon, record.end_location.lat, record.end_location.lon, record.start_at, record.end_at, record.elapsed_time, record.average_mpg, record.fuel_cost, record.distance_in_miles]
          end

          headings = ['ID', 'Vehicle', 'Start Latitude', 'Start Longitude', 'End Latitude', 'End Longitude', 'Start Time', 'End Time', 'Duration', 'Average MPG', 'Fuel Cost', 'Distance']

          CSV.open(filename, "w+") do |csv|
            csv << headings

            trips.each do |trip|
              csv << trip_row.call(trip)
            end
          end

          puts "Success! Trips have been exported to %s" % [filename]
        else
          puts "No Trips to export."
        end
      end

      desc 'all', 'List all Automatic Trips'
      def all
        puts "\n"

        trips = Automatic::Client::Trips.all

        if trips.any?
          date_format = "%B %d %Y @ %I:%M%P"

          trip_row = ->(index,record) do
            [index, record.id, record.vehicle.display_name, record.start_location.name, record.end_location.name, record.start_at.strftime(date_format), record.end_at.strftime(date_format), ("%.2f" % [record.elapsed_time]), ("%.2f" % [record.average_mpg]), ("%.2f" % [record.fuel_cost]), ("%.2f" % [record.distance_in_miles])]
          end

          title    = "Automatic Trips"
          headings = ['#', 'ID', 'Vehicle', 'Start Location', 'End Location', 'Start Time', 'End Time', 'Duration (Minutes)', 'Average MPG', 'Fuel Cost', 'Distance (Miles)']
          rows     = trips.each_with_index.map { |record, index| trip_row.call((index + 1), record) }
          table    = Terminal::Table.new(title: title, headings: headings, rows: rows)

          puts table.to_s
        else
          puts "No Trips found."
        end
        puts "\n"
      end
    end
  end
end
