require 'csv'
require 'thor'
require 'terminal-table'

require File.expand_path('../../client', __FILE__)

module Automatic
  module CommandLine
    class Trip < Thor
      desc 'show', 'List all Automatic Trips'
      option :id, type: :string, banner: 'TRIP_ID', required: true
      def show
        puts "\n"

        trips = [Automatic::Client::Trips.find_by_id(options[:id])]

        if trips.any?
          date_format = "%B %d %Y @ %I:%M%P"

          trip_row = ->(index,record) do
            #[index, record.id, record.vehicle.display_name, record.start_location.name, record.end_location.name, record.start_at.strftime(date_format), record.end_at.strftime(date_format), ("%.2f" % [record.elapsed_time]), ("%.2f" % [record.average_mpg]), ("%.2f" % [record.fuel_cost]), ("%.2f" % [record.distance_in_miles])]
            [index, record.id, record.vehicle.display_name, record.start_location.name, record.end_location.name, record.start_at.strftime(date_format), record.end_at.strftime(date_format), ("%.2f" % [record.average_mpg]), ("%.2f" % [record.fuel_cost]), ("%.2f" % [record.distance_in_miles])]
          end

          title    = "Automatic Trips"
          headings = ['#', 'ID', 'Vehicle', 'Start Location', 'End Location', 'Start Time', 'End Time', 'Average MPG', 'Fuel Cost', 'Distance (Miles)']
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
