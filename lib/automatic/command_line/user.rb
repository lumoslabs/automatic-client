require 'thor'
require 'terminal-table'

require File.expand_path('../../client', __FILE__)

module Automatic
  module CommandLine
    class User < Thor
      desc 'show', 'Show details for specific User'
      option :id, type: :string, banner: 'USER_ID', required: true
      def show
        puts "\n"

        users = [Automatic::Models::Users.find_by_id(options[:id])]

        if users.any?
          vehicle_row = ->(index,record) do
            [index, record.id, record.first_name, record.last_name, record.username, record.email]
          end

          title    = "Automatic Users"
          headings = ['#', 'ID', 'First Name', 'Last Name', 'Username', 'E-Mail']
          rows     = users.each_with_index.map { |record, index| vehicle_row.call((index + 1), record) }
          table    = Terminal::Table.new(title: title, headings: headings, rows: rows)

          puts table.to_s
        else
          puts "No Users found."
        end
        puts "\n"
      end
    end
  end
end
