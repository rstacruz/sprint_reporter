require 'test_helper'

describe 'Jira Parser' do
  describe 'fixture' do
    let :fixture_path do
      File.expand_path('../../example/JIRA.csv', __FILE__)
    end

    let :items do
      SprintReporter::JiraParser.get_items(fixture_path)
    end

    it 'works' do
      expect(items.length).must_equal 8
    end

    it 'has the correct first item' do
      expect(items[0]).must_equal(
        title: 'Sign up',
        key: 'PR-12',
        type: 'Feature',
        status: 'Closed',
        epic: 'PR-2',
        priority: 'Medium',
        links: []
      )
    end

    it 'parses trello URLs' do
      item = items.select { |it| it[:key] == 'PR-19' }.first

      expect(item[:links]).must_equal([
        { host: 'trello.com', url: 'https://trello.com/card/foobar' }
      ])
    end
  end
end
