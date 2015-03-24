require 'thor'
require 'terminal-table'

require File.expand_path('../../client', __FILE__)

module Automatic
  module CommandLine
    class Webhooks < Thor
      desc 'all', 'List all Automatic Webhooks'
      def all
        puts "\n"

        webhooks = Automatic::Client.webhooks

        if webhooks.any?
          webhook_row = ->(index,record) do
            [index, record.name, record.description]
          end

          title    = "Automatic Webhooks"
          headings = ['#', 'Name', 'Description']
          rows     = webhooks.each_with_index.map { |record, index| webhook_row.call((index + 1), record) }
          table    = Terminal::Table.new(title: title, headings: headings, rows: rows)

          puts table.to_s
        else
          puts "No Webhooks found."
        end
        puts "\n"
      end
    end
  end
end
