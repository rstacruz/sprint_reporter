require 'csv'

module JiraParser
  module_function

  def get_items
    map_rows CSV.foreach('./JIRA.csv', headers: true)
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
    require 'yaml'
    YAML.dump(@items)
  end
end

items = JiraParser.get_items
output = Renderer.new(items, domain: 'foo.atlassian.net').render
puts output
