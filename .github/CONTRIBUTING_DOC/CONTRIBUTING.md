## Contributor Guidelines

## Issues

### Feature Requests

If you have ideas or how to improve our projects, you can suggest features by opening a GitHub issue. Make sure to include details about the feature or change, and describe any uses cases it would enable.

Feature requests will be tagged as `[enhancement]` and their status will be updated in the comments of the issue.

### Bugs

When reporting a bug or unexpected behaviour in a project, make sure your issue describes steps to reproduce the behaviour, including the platform you were using, what steps you took, and any error messages.

Reproducible bugs will be tagged as `[bug]` and their status will be updated in the comments of the issue.

### Wontfix

Issues will be closed and tagged as `[wontfix]` if we decide that we do not wish to implement it, usually due to being misaligned with the project vision or out of scope. We will comment on the issue with more detailed reasoning.

## Contribution Workflow

### Open Issues

If you're ready to contribute, new issues click here [issues/new/choose](../../../../issues/new/choose)

> if this repo has opened issues, start by looking at our open issues tagged as [`help wanted`](../../../../issues?q=is%3Aopen+is%3Aissue+label%3A"help+wanted") or [`good first issue`](../../../../issues?q=is%3Aopen+is%3Aissue+label%3A"good+first+issue").

You can comment on the issue to let others know you're interested in working on it or to ask questions.

### Making Changes

1. Fork the repository.

2. Create a new feature branch.

3. Make your changes. Ensure that there are no build errors by running the project with your changes locally.

4. git commit use [https://www.conventionalcommits.org/](https://www.conventionalcommits.org/)

  - Can use command tools as: [cz-cli](https://github.com/commitizen/cz-cli#conventional-commit-messages-as-a-global-utility)

![](https://github.com/commitizen/cz-cli/raw/master/meta/screenshots/add-commit.png)

  - vscode plugin `Conventional Commits`  [https://marketplace.visualstudio.com/items?itemName=vivaxy.vscode-conventional-commits](https://marketplace.visualstudio.com/items?itemName=vivaxy.vscode-conventional-commits)

`Command + Shift + P` or `Ctrl + Shift + P` enter `Conventional Commits` or `cc `, and press `Enter`

![](https://github.com/vivaxy/vscode-conventional-commits/raw/HEAD/assets/docs/demo.gif)

  - jetbrains IDE can use `Conventional Commit` [https://plugins.jetbrains.com/plugin/13389-conventional-commit](https://plugins.jetbrains.com/plugin/13389-conventional-commit)

![https://plugins.jetbrains.com/files/13389/screenshot_21408.png](https://plugins.jetbrains.com/files/13389/screenshot_21408.png)

5. Open a pull request with a name and description of what you did. You can read more about working with pull requests on GitHub [here](https://help.github.com/en/articles/creating-a-pull-request-from-a-fork).

6. A maintainer will review your pull request and may ask you to make changes.

## Commit Specification

> For more, See [Commit convention](https://www.conventionalcommits.org/en/v1.0.0/)

### Format

> Commit message includes three parts：header，body and footer, which separated by blank lines.

```
<type>[optional scope]: <description>
// blank lines
[optional body]
// blank lines
[optional footer(s)]

```

#### Header

Header has only one line, including three fields：`type`（required），`scope`（），description（required）

The types of `type` includes：

| type     | instructions                                                                                                                                                   |
|----------|----------------------------------------------------------------------------------------------------------------------------------------------------------------|
| feat     | new feature                                                                                                                                                    |
| fix      | fixes                                                                                                                                                          |
| perf     | changes improving code performance                                                                                                                             |
| style    | Changes to the format class of the code, like using `gofmt` to format codes, delete the blank lines, etc.                                                      |
| refactor | Changes to other classes of the code, which do not belong to feat、fix、perf and style, like simplifying code, renaming variables, removing redundant code, etc. |
| test     | Add test cases or update existing test cases                                                                                                                   |
| ci       | Changes to continuous integration and continuous deployment, like modifying Ci configuration files or updating systemd unit files.                             |
| docs     | Updates to document classes, including modifying user documents, developing documents, etc.                                                                    |
| chore    | Other types, like building processes, dependency management, changes to auxiliary tools, etc.                                                                  |

`scope` is used to illustrate the scope of the impact of commit, scope is as follows:

- tskv
- meta
- query
- docs
- config
- tests
- utils
- \*

`description` is the short description of commit, which is specified not to exceed 72 characters.

#### Body

> Body is a detailed description of this commit, which can be divided into multiple lines.
>
> Notes:
>
> - Use the first person and present tense, like using change instead of changed or changes.
> - Describe the motivations for code changes in detail and the comparison of before and after behavior

#### Footer

> If the current code is not compatible with the previous version, the Footer section begins with BREAKING CHANGE, which
> is followed by a description of the changes, as well as the reasons for the changes and the method of migration.
>
> Close Issue, if the current commit is for an issue, you can close the issue in the Footer section

```
Closes #1234,#2345

```

#### Revert

> In addition to the Header, Body, and Footer, Commit Message has a special case: If the current commit restores a
> previous commit, it should start with revert:, which is followed by a header of a restored commit. Besides, it must be
> written as This reverts commit in the Body. Among them, hash is the SHA identity of the commit to be restored.

## generate kit

- See [gh-conventional-kit](https://github.com/sinlov/gh-conventional-kit) to get more info