module SprintReporter
  module JiraParser
    module_function

    def get_items(filename)
      require 'csv'
      enum = CSV.foreach(filename, headers: true)
      map_rows enum
    end

    def map_rows(enumerator)
      enumerator.map do |row|
        map_row(row)
      end
    end

    def map_row(row)
      item = {
        title: row['Summary'],
        key: row['Issue key'], # => 'PROJ-123'
        type: row['Issue Type'], # => 'Bug'
        status: row['Status'], # => 'Closed'
        epic: row['Custom field (Epic Link)'], # => 'PROJ-111'
      }
    end
  end
end
