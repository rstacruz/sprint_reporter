require_relative './sprint_reporter'

items = SprintReporter::JiraParser.get_items('./JIRA.csv')
output = SprintReporter::MarkdownRenderer.new(items, domain: 'foo.atlassian.net').render
puts output
