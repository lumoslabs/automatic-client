require 'thor'
require 'terminal-table'

require File.expand_path('../../client', __FILE__)

module Automatic
  module CommandLine
    class Scopes < Thor
      desc 'all', 'List all Automatic Authorization Scopes'
      def all
        puts "\n"

        scopes = Automatic::Client.scopes

        if scopes.any?
          scope_row = ->(index,record) do
            [index, record.name, record.description]
          end

          title    = "Automatic Scopes"
          headings = ['#', 'Name', 'Description']
          rows     = scopes.each_with_index.map { |record, index| scope_row.call((index + 1), record) }
          table    = Terminal::Table.new(title: title, headings: headings, rows: rows)

          puts table.to_s
        else
          puts "No Scopes found."
        end
        puts "\n"
      end
    end
  end
end
