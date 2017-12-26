require 'test_helper'

describe 'Jira Parser' do
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
      epic: 'PR-2'
    )
  end
end
