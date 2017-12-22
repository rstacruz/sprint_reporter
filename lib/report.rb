require 'csv'

module JiraParser
  module_function

  def get_items(filename)
    map_rows CSV.foreach(filename, headers: true)
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

class Renderer
  def initialize(items, domain:)
    @items = items
    @domain = domain
  end

  def render
    @items.map do |item|
      render_item(item)
    end.join("\n")
  end

  def render_item(item)
    url = "https://#{@domain}/browse/#{item[:key]}"
    "- [`#{item[:key]}`](#{url}) #{item[:title]}"
  end
end

items = JiraParser.get_items('./JIRA.csv')
output = Renderer.new(items, domain: 'foo.atlassian.net').render
puts output
