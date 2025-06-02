## 贡献者指南

## Issues

### 功能请求

如果您有想法或如何改进我们的项目，您可以通过打开GitHub问题来建议功能。确保包含有关功能或更改的详细信息，并描述它将启用的任何用例。

功能请求将被标记为 `[enhancement]`，并且其状态将在问题的注释中更新。

### Bugs

在报告项目中的bug或意外行为时，请确保您的问题描述了重现行为的步骤，包括您使用的平台、您采取的步骤以及任何错误消息。

可重现的错误将被标记为 `[bug]`，并且其状态将在问题的注释中更新。

### 不会修复

如果我们决定不希望实施问题，通常是由于与项目愿景不一致或超出范围而导致问题将被关闭并标记为 `[wontfix]`。我们将用更详细的推理来评论这个问题。

## 贡献工作流

### 新建 Issues

如果您准备贡献，请单击此处 [issues/new/choose](../../../../../issues/new/choose)

> 如果此repo已打开问题，请首先查看我们标记为
> [`help wanted`](../../../../../issues?q=is%3Aopen+is%3Aissue+label%3A"help+wanted")
> 或者 [`good first issue`](../../../../../issues?q=is%3Aopen+is%3Aissue+label%3A"good+first+issue").

你可以对这个问题发表评论，让别人知道你有兴趣解决这个问题，或者提出问题.

### 更改流程

1. Fork 存储库

2. 创建一个新的 feature branch.

3. 进行更改。通过在本地运行带有更改的项目来确保没有构建错误。

4. git commit 使用 [https://www.conventionalcommits.org/](https://www.conventionalcommits.org/)

- 可以使用命令工具作为: [cz-cli](https://github.com/commitizen/cz-cli#conventional-commit-messages-as-a-global-utility)

![](https://github.com/commitizen/cz-cli/raw/master/meta/screenshots/add-commit.png)

- vscode插件 `Conventional Commits`  [https://marketplace.visualstudio.com/items?itemName=vivaxy.vscode-conventional-commits](https://marketplace.visualstudio.com/items?itemName=vivaxy.vscode-conventional-commits)

`Command + Shift + P` 或者 `Ctrl + Shift + P` 输入 `Conventional Commits` or `cc `, 并按 `Enter`

![](https://github.com/vivaxy/vscode-conventional-commits/raw/HEAD/assets/docs/demo.gif)

- jetbrains IDE 可以使用 `Conventional Commit` [https://plugins.jetbrains.com/plugin/13389-conventional-commit](https://plugins.jetbrains.com/plugin/13389-conventional-commit)

![https://plugins.jetbrains.com/files/13389/screenshot_21408.png](https://plugins.jetbrains.com/files/13389/screenshot_21408.png)

5. 新建一个 pull request ，其中包含您所做的工作的名称和描述。您可以阅读有关在GitHub上处理拉取请求的更多信息 [here](https://help.github.com/en/articles/creating-a-pull-request-from-a-fork).

6. 维护者将审查您的拉取请求，并可能要求您进行更改。

## Commit规范

> 详细内容请参考：[Commit规范](https://www.conventionalcommits.org/en/v1.0.0/)

### 格式

> Commit message 包含三个部分：header，body和footer，中间用空行隔开。

```
<type>[optional scope]: <description>
// 空行
[optional body]
// 空行
[optional footer(s)]
```

#### Header

Header只有一行，包含三个字段：`type`（必需），`scope`（可选），description（必需）

`type`的种类包括：

| 类型       | 说明                                                       |
|----------|----------------------------------------------------------|
| feat     | 新增功能                                                     |
| fix      | Bug修复                                                    |
| perf     | 提高代码性能的变更                                                |
| style    | 代码格式类的变更，比如用`gofmt`格式化代码、删除空行等                           |
| refactor | 其他代码类的变更，这些变更不属于feat、fix、perf和style，例如简化代码、重命名变量、删除冗余代码等 |
| test     | 新增测试用例或是更新现有测试用例                                         |
| ci       | 持续集成和部署相关的改动，比如修改CI配置文件或者更新systemd unit文件                |
| docs     | 文档类的更新，包括修改用户文档或者开发文档等                                   |
| chore    | 其他类型，比如构建流程、依赖管理或者辅助工具的变动等                               |

`scope`用于说明commit影响的范围，scope 如下：

- tskv
- meta
- query
- docs
- config
- tests
- utils
- \*

`description`是commit的简短描述，规定不超过72个字符

#### Body

> Body是对本次commit的详细描述，可以分成多行
>
> 注意点：
>
> - 使用第一人称现在时，比如使用change而不是changed或changes。
> - 详细描述代码变动的动机，以及前后行为的对比

#### Footer

> 如果当前代码与上一个版本不兼容，则 Footer 部分以BREAKING CHANGE开头，后面是对变动的描述、以及变动理由和迁移方法。

> 关闭Issue，如果当前 commit 针对某个issue，那么可以在 Footer 部分关闭这个 issue

```
Closes #1234,#2345
```

#### Revert

> 除了 Header、Body 和 Footer 这 3 个部分，Commit Message 还有一种特殊情况：如果当前 commit 还原了先前的 commit，则应以
> revert: 开头，后跟还原的 commit 的 Header。而且，在 Body 中必须写成 This reverts commit ，其中 hash 是要还原的 commit 的 SHA
> 标识。