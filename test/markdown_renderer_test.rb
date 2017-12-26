require 'test_helper'

describe 'MarkdownRenderer' do
  it 'works with epics' do
    items = [
      { key: 'PR-12', type: 'Feature', title: 'Sign up', epic: 'PR-2' },
      { key: 'PR-13', type: 'Feature', title: 'Sign out', epic: 'PR-2' },
      { key: 'PR-14', type: 'Feature', title: 'Write posts', epic: 'PR-3' },
      { key: 'PR-16', type: 'Feature', title: 'Deployment', epic: nil },
      { key: 'PR-15', type: 'Feature', title: 'Make comments', epic: 'PR-3' },
      { key: 'PR-17', type: 'Bug', title: 'Log in not working', epic: 'PR-2' },
      { key: 'PR-18', type: 'Feature', title: 'Podcast download', epic: 'PR-4' },
      { key: 'PR-19', type: 'Feature', title: 'Podcast listen', epic: 'PR-4' },
    ]

    epics = {
      'PR-3' => 'Blogging',
      'PR-2' => 'User management',
      'PR-1' => 'Not supposed to be here'
    }

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

      - [`PR-12`](https://foo.atlassian.net/browse/PR-12) Sign up
      - [`PR-13`](https://foo.atlassian.net/browse/PR-13) Sign out
      - [`PR-17`](https://foo.atlassian.net/browse/PR-17) Log in not working

      ## PR-4

      - [`PR-18`](https://foo.atlassian.net/browse/PR-18) Podcast download
      - [`PR-19`](https://foo.atlassian.net/browse/PR-19) Podcast listen

      ## Other

      - [`PR-16`](https://foo.atlassian.net/browse/PR-16) Deployment
    END
  end

  it 'works without epics' do
    items = [
      { key: 'PR-12', type: 'Feature', title: 'Sign up', epic: 'PR-2' },
      { key: 'PR-13', type: 'Feature', title: 'Sign out', epic: 'PR-2' },
      { key: 'PR-14', type: 'Feature', title: 'Write posts', epic: 'PR-3' },
      { key: 'PR-16', type: 'Feature', title: 'Deployment', epic: nil },
      { key: 'PR-15', type: 'Feature', title: 'Make comments', epic: 'PR-3' },
      { key: 'PR-17', type: 'Bug', title: 'Log in not working', epic: 'PR-2' },
      { key: 'PR-18', type: 'Feature', title: 'Podcast download', epic: 'PR-4' },
      { key: 'PR-19', type: 'Feature', title: 'Podcast listen', epic: 'PR-4' },
    ]

    output = SprintReporter::MarkdownRenderer.new(
      items,
      domain: 'foo.atlassian.net',
      epics: nil
    ).render

    expect(output.strip).must_equal <<~END.strip
      ## PR-2

      - [`PR-12`](https://foo.atlassian.net/browse/PR-12) Sign up
      - [`PR-13`](https://foo.atlassian.net/browse/PR-13) Sign out
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
