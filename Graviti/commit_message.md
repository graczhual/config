Commit message 在软件开发中非常重要

# 为什么需要写好 Commit Message ？

-   好的 commit message 向开发者们（包括自己）更好地传达了代码提交的上下文
-   好的 commit message 传达了!!为什么!!做出这样的修改，而 diff 只能传达修改了什么
-   好的 commit message 使得定位 bug 更加容易
-   好的 commit message 使得 `CHANGELOG` 的生成更加容易
-   好的 commit message 便于筛选同类型的提交
-   ......

---

# 规范与格式

#### 基本规范：

-   仅使用 ASCII 字符
-   标题不超过 72 个字符

NOTE: github 会对标题超过 72 个字符的提交进行折叠，phabricator 则为 80

#### 基本格式：

参考：[Conventional Commits](https://www.conventionalcommits.org/)

```
lang
<type>(<optional scope>): <description>  # Header
                                         # Blank line
<optional body>                          # Body
                                         # Blank line
<optional footer(s)>                     # Footer
```

每个 commit message 包括三个部分：`Header`(必填)，`Body`(选填)，`Footer`(选填), 三个部分之间以空行隔开

---

# 格式说明

#### 提交标题：`Header`

`Header`是本次提交的概括，只有一行，包括三个部分：`type`(必填)，`scope`(选填)，`description`(必填)

1. `type`: 用于说明提交的类型，以下为可选择的 12 个类型 （基于：[the Angular convention](https://github.com/angular/angular/blob/22b96b9/CONTRIBUTING.md#-commit-message-guidelines)）
    - `feat`: 新功能
    - `fix`: bug 修复
    - `docs`: 文档
    - `style`: 不影响代码逻辑的格式修改
    - `refactor`: 代码重构
    - `perf`: 性能提升
    - `test`: 测试
    - `build`: 编译系统和外部依赖
    - `ci`: CI 配置与 CI 脚本
    - `chore`: 其他修改
    - `revert`: 对之前的提交进行 revert
    - `release`: 发布版本
2. `scope`: 用于说明提交的影响范围，用圆括号包裹
3. `description`: 提交的一句话概括
    - 以动词开头，使用第一人称现在时
    - 第一个字母小写
    - 结尾不加句号

NOTE: 如果提交无法用一句话概括，那么很可能需要将其拆分为多个提交

---

#### 提交正文：`Body`

`Body`是本次提交的详细总结，着重描述!!为什么!!修改，而不是修改了什么

---

#### 提交脚注：`Footer`

`Footer`用于填写其他提交相关的信息

1. 接口发生变化并且与之前版本不兼容时:
    - 在 Footer 中添加`BREAKING CHANGE:`字段，之后添加对该变动的描述/理由/迁移方法
    - 同时在`Header`中 type/scope 和冒号之间添加感叹号`!`（见 Example 3）
2. 添加有需要添加的其他信息，例如：
    - 修复了某个 bug：`Fix: #123`
    - reviewer 信息：`Reviewed-by: XXX`
    - 和某个提交相关：`See-also: fe3187489d69c4`
    - ...... （参考：[git-interpret-trailers](https://git-scm.com/docs/git-interpret-trailers)）

---

# Examples

1. 普通提交

```
docs: correct spelling of CHANGELOG
```

2. 带有 scope 的提交

```
feat(lang): add polish language
```

3. 带有 `BREAKING CHANGE` 的提交

```
refactor!: drop support for Node 6

BREAKING CHANGE: refactor to use JavaScript features not available in Node 6.
```

4. 带有正文和脚注的提交

```
fix: correct minor typos in code

see the issue for details

on typos fixed.

Reviewed-by: Z
Refs #133
```

---

# 辅助工具

建议使用 [commitizen/cz-cli](https://github.com/commitizen/cz-cli) 工具辅助编写 commit message

#### 安装方法

```
lang=bash
npm install -g commitizen
```

MacOS 也可以使用 `brew` 安装：

```
lang=bash
brew install commitizen
```

NOTE: `brew`安装的版本和`npm`安装的版本使用逻辑有些不一样，推荐使用`npm`安装

#### 使用方法

使用命令 `cz` 或者 `git cz` 来代替 `git commit`
输入命令后根据命令行指示操作即可

> 配置以及更多拓展使用参考 [commitizen/cz-cli](https://github.com/commitizen/cz-cli) 官方github

---

# Reference

-   [Conventional Commits](https://www.conventionalcommits.org/)
-   [the Angular convention](https://github.com/angular/angular/blob/22b96b9/CONTRIBUTING.md#-commit-message-guidelines)
-   [git-interpret-trailers](https://git-scm.com/docs/git-interpret-trailers)
-   [commitizen/cz-cli](https://github.com/commitizen/cz-cli)
-   [cz-conventional-changelog](https://github.com/commitizen/cz-conventional-changelog)
-   [conventional-changelog](https://github.com/conventional-changelog/conventional-changelog)
-   [commitlint](https://github.com/conventional-changelog/commitlint)
-   [gitlint](https://github.com/jorisroovers/gitlint)
