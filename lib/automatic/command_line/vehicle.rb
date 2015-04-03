require 'thor'
require 'terminal-table'

require File.expand_path('../../client', __FILE__)

module Automatic
  module CommandLine
    class Vehicle < Thor
      desc 'show', 'List all Automatic Vehicles'
      option :id, type: :string, banner: 'VEHICLE_ID', required: true
      def show
        puts "\n"

        vehicles = [Automatic::Models::Vehicles.find_by_id(options[:id])]

        if vehicles.any?
          vehicle_row = ->(index,record) do
            [index, record.id, record.year, record.make, record.model, record.sub_model, record.color, record.display_name, record.full_name]
          end

          title    = "Automatic Vehicles"
          headings = ['#', 'ID', 'Year', 'Make', 'Model', 'Sub Model', 'Color', 'Display Name', 'Full Name']
          rows     = vehicles.each_with_index.map { |record, index| vehicle_row.call((index + 1), record) }
          table    = Terminal::Table.new(title: title, headings: headings, rows: rows)

          puts table.to_s
        else
          puts "No Vehicles found."
        end
        puts "\n"
      end
    end
  end
end
