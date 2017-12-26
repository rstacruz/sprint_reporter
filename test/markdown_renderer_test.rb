require 'test_helper'

describe 'MarkdownRenderer' do
  let :fixture_path do
    File.expand_path('../../example/JIRA.csv', __FILE__)
  end

  let :items do
    SprintReporter::JiraParser.get_items(fixture_path)
  end


  let :epics do
    YAML.load_file(
      File.expand_path('../../example/epics.yml', __FILE__)
    )
  end

  it 'works with epics' do
    output = SprintReporter::MarkdownRenderer.new(
      items,
      domain: 'foo.atlassian.net',
      epics: epics
    ).render

    expect(output.strip).must_equal <<~END.strip
      ## Blogging

      - [`PR-14`](https://foo.atlassian.net/browse/PR-14) Write posts
      - [`PR-15`](https://foo.atlassian.net/browse/PR-15) Make comments

      ## User management

      - [`PR-13`](https://foo.atlassian.net/browse/PR-13) **Sign out**
      - [`PR-12`](https://foo.atlassian.net/browse/PR-12) Sign up
      - [`PR-17`](https://foo.atlassian.net/browse/PR-17) Log in not working

      ## PR-4

      - [`PR-18`](https://foo.atlassian.net/browse/PR-18) Podcast download
      - [`PR-19`](https://foo.atlassian.net/browse/PR-19) Podcast listen

      ## Other

      - [`PR-16`](https://foo.atlassian.net/browse/PR-16) Deployment
    END
  end

  it 'works without epics' do
    output = SprintReporter::MarkdownRenderer.new(
      items,
      domain: 'foo.atlassian.net',
      epics: nil
    ).render

    expect(output.strip).must_equal <<~END.strip
      ## PR-2

      - [`PR-13`](https://foo.atlassian.net/browse/PR-13) **Sign out**
      - [`PR-12`](https://foo.atlassian.net/browse/PR-12) Sign up
      - [`PR-17`](https://foo.atlassian.net/browse/PR-17) Log in not working

      ## PR-3

      - [`PR-14`](https://foo.atlassian.net/browse/PR-14) Write posts
      - [`PR-15`](https://foo.atlassian.net/browse/PR-15) Make comments

      ## PR-4

      - [`PR-18`](https://foo.atlassian.net/browse/PR-18) Podcast download
      - [`PR-19`](https://foo.atlassian.net/browse/PR-19) Podcast listen

      ## Other

      - [`PR-16`](https://foo.atlassian.net/browse/PR-16) Deployment
    END
  end
end
