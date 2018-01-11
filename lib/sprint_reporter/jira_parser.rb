require 'uri'

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
        priority: row['Priority'], # => 'Highest'
        links: get_links(row)
      }
    end

    def get_links(row)
      desc = row['Description'] || ''
      urls = desc.scan(/https?:\/\/[A-Za-z0-9\.\/\?&%=\+]+/) || []

      urls.map do |url|
        uri = URI.parse(url)
        host = uri.host
        { host: host, url: url }
      end
    end
  end
end
