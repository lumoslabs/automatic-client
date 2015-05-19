require 'thor'
require 'terminal-table'

require File.expand_path('../../client', __FILE__)

module Automatic
  module CommandLine
    class Routes < Thor
      desc 'all', 'List all Automatic Routes'
      def all
        puts "\n"

        routes = Automatic::Client.routes

        if routes.any?
          route_row = ->(index,record) do
            [index, record.name, record.path]
          end

          title    = "Automatic Routes"
          headings = ['#', 'Rel', 'Description']
          rows     = routes.each_with_index.map { |record, index| route_row.call((index + 1), record) }
          table    = Terminal::Table.new(title: title, headings: headings, rows: rows)

          puts table.to_s
        else
          puts "No Routes found."
        end
        puts "\n"
      end
    end
  end
end
