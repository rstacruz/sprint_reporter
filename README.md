# sprint_reporter

> Eats Jira CSV's and makes pretty Markdown

Creates Markdown-formatted report of a Jira sprint's completed features.

> <img src='https://user-images.githubusercontent.com/74385/34355860-77fc90ae-ea73-11e7-8fec-7405cd0fd4a1.png' width='300'>

## Usage

- In Jira, go to **Reports** → **Sprint Report**. Then click **View in Issue Navigator**.

  > <img src='https://user-images.githubusercontent.com/74385/34355696-5c91e8ec-ea72-11e7-964a-0ab49c1d032c.png' width='200'>

- In the Issue Navigator, click **Export** (icon) → **Export Excel CSV (all fields)**. This will let you download a CSV file.

  > <img src='https://user-images.githubusercontent.com/74385/34355778-0d49f7e2-ea73-11e7-8d20-00a2ca78f103.png' width='200'>

- Pass this CSV file to *sprint_reporter* via `--jira`.

  ```sh
  sprint_reporter --jira JIRA.csv
  ```

## Thanks

**sprint_reporter** © 2017, Rico Sta. Cruz. Released under the [MIT] License.<br>
Authored and maintained by Rico Sta. Cruz with help from contributors ([list][contributors]).

> [ricostacruz.com](http://ricostacruz.com) &nbsp;&middot;&nbsp;
> GitHub [@rstacruz](https://github.com/rstacruz) &nbsp;&middot;&nbsp;
> Twitter [@rstacruz](https://twitter.com/rstacruz)

[![](https://img.shields.io/github/followers/rstacruz.svg?style=social&label=@rstacruz)](https://github.com/rstacruz) &nbsp;
[![](https://img.shields.io/twitter/follow/rstacruz.svg?style=social&label=@rstacruz)](https://twitter.com/rstacruz)

[MIT]: http://mit-license.org/
[contributors]: http://github.com/rstacruz/jira-reporter/contributors
