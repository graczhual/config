## 0. 初始化

-   若是第一次使用 Github，请参考 [[/w/graviti_engineering/phabricator/Github初始化 | Github初始化]]

### 安装 `hit-cli`：

-   通过 `pip3` 安装 `hit-cli`

```
lang=bash
pip3 install hit-cli
```

NOTE: `hit-cli` 依赖于 `git` 命令行工具，请确保自己机器上 `git` 已经安装

参考：[`hit`源码](https://github.com/Graviti-AI/hit-cli)

### 初始化 `hit-cli`：

开始使用 `hit-cli` 之前需要对其进行授权，需要以下权限：

-   (必须) github 访问权限 —— 用于创建 PR，提交代码等操作
-   (可选) phabricator 访问权限 —— 用于将 PR 链接发送至 phabricator task

执行以下命令开始 Github 授权：

```
lang=bash
hit auth
```

之后根据命令行提示进行操作即可

---

执行以下命令开始 Phabricator 授权：

```
lang=bash
hit auth --phabricator
```

之后根据命令行提示进行操作即可

---

#### 名词解释

Github 开发流程需要对仓库进行 fork，代码仓库变成了两个，一个是被 fork 的原始仓库， 一个是 fork 之后在自己名下的仓库，
本文为了便于区分:

-   将被 fork 的原始仓库称为!!主仓库!!，前缀为 `Graviti-AI/`
-   将 fork 之后自己名下的仓库称为!!开发仓库!!，前缀为自己的用户名

---

## 1. 准备代码仓库

```
lang=bash
hit clone Graviti-AI/<repo_name>
```

NOTE: 例如要克隆 TensorBaySDK 的源码，(Github 网址为：<https://github.com/Graviti-AI/tensorbay-python-sdk>)，那么应该输入 `hit clone Graviti-AI/tensorbay-python-sdk`

该命令会将完成以下 5 件事：

1. 将主仓库 fork 至自己名下（若已经 fork 则会自动跳过）
2. 将开发仓库 clone 至本地
3. 为 clone 至本地的仓库配置一个名为 `upstream` 的 remote 地址指向主仓库
4. 将主仓库配置为 `gh` 命令行工具的 base repository
5. 初始化仓库的 pre-commit scripts，参考 [[/w/graviti_algorithm/数据中心_python_sdk/pre-commit调研文档/ | pre-commit使用文档]]

上述名为 `upstream` 的 remote 地址对 `hit` CLI 同步功能十分重要，可以通过 `git remote -v` 命令查看

---

## 2. 新建开发分支

```
lang=bash
cd <repo_dir>/  # 进入本地仓库文件夹
hit pull        # 将本地和远端的开发仓库 main 分支与主仓库 main 分支同步至最新
```

IMPORTANT: 不要在本地 main 分支上提交代码，所有修改都在开发分支上进行

IMPORTANT: 否则 `hit pull` 会因为代码无法快进而失败

```
lang=bash, name=新建并切换至开发分支
git checkout -b <new_branch_name>

# 上述命令等于下面个两条命令：
# git branch <new_branch_name>    # 新建分支
# git checkout <new_branch_name>  # 切换分支
```

NOTE: 若通过 `hit auth --phabricator` 进行过授权，`hit` 支持将 PR 与 Phabricator Task 进行关联。命名分支名时以对应的 Task ID 开头，如`T100_bug_fix`，hit 会自动将该提交和`T100`关联

---

## 3. 修改并提交代码

使用喜欢的编辑器修改代码，之后使用 `git` 提交修改：

```
lang=bash
git add <modified_file> # 使用 git add 告诉 git 那些文件需要提交
git commit              # 使用 git commit 提交 git add 的文件，在弹出的编辑器中填写 commit message
```

WARNING: 请认真填写 commit message，不要在 commit message 中填写中文，参考 [[/w/graviti_engineering/代码规范/commitmessage/ | Commit message 编写规范]]

```
lang=bash
# 需要多次 commit 时推荐使用 --amend 选项将新的修改提交至上一个 commit 之中
# 保持开发分支的修改都在一个 commit 中
git commit --amend
```

NOTE: 开发分支应该只有一个包含本任务所有修改的 commit，这样可以避免 rebase 过程中代码多次冲突的问题。

---

## 4. 使用 Rebase 更新代码

在本地开发的过程中，主仓库大概率已经增加了许多其他人开发的 commit，
推荐在提交 pull request 之前在本地更新代码，解决冲突

```
lang=bash
hit pull         # 将本地和远端的开发仓库 main 分支与主仓库 main 分支同步至最新
git rebase main  # 使用 rebase 将本地的开发分支和 main 分支同步
```

```
lang=bash, name=若 rebase 过程中出现冲突，可以通过以下流程修复冲突
0. git status  # 查看冲突文件
1. 打开文件，修复冲突代码
2. git add <conflict_file>
3. git rebase --continue
Done
```

WARNING: 合并代码时只使用 rebase，不使用 merge

---

## 5. push 本地修改至远端, 并创建/更新 pull request

NOTE: 每次提交的代码不要超过 400 行，如果超过，则考虑进行拆分

```
lang=bash
# 使用 hit push 命令将本地提交推送至远端
# 如果对应的 pull request 还未创建，则跟随弹出的交互式命令行创建 pull request
hit push

# 如果使用了 git commit --amend 或者 git rebase 使得本地分支和远端开发分支发生冲突时
# 可以添加 `-f` flag 强制更新，使用方法与 `git push -f` 相同
hit push -f
```

打开最后弹出的链接即可链接至 pull request 页面

---

## 6. 代码审查

-   指定 reviewer：
    -   可以在创建 pull request 页面右侧进行指定 reviewer 等操作
    -   也可以在创建成功后的 pull requset 页面右侧进行
-   通知对应的 reviewer 进行代码 review

提交的代码会由于各种原因无法合并到主仓库，例如：

-   review 不通过
-   CI 检查不通过
-   和主仓库发生冲突
-   等等

遇到无法合并需要修改代码时，重复上述 3，4，5 三个步骤，
在第 5 步 `hit push` 之后，pull request 会自动更新

---

## 7. 合并代码至主仓库

在 review 同意之后，可以将代码合并至主仓库

```
lang=bash
hit land
# 跟随弹出的交互式命令行进行后续操作
```

`hit land` 命令仅支持 `Rebase and merge` 策略进行合并， 保证主仓库的提交历史为线性
如果需要使用其他合并策略，请联系仓库管理员

合并成功之后会：

1. 自动删除本地和远端的开发分支
2. 自动切换回 main 分支
3. 自动将本地和远端的开发仓库 main 分支与主仓库 main 分支同步至最新

---

## 8. 成功合并后清理本地仓库

如果使用 `hit land` 命令进行合并，则不需要进行仓库清理
如果是通过其他方式进行合并（例如网页，`gh pr merge`命令，管理员等），可以使用以下命令清理仓库：

```
lang=bash
hit clean  # 删除当前分支和对应的远端分支
hit pull   # 将本地和远端的开发仓库 main 分支与主仓库 main 分支同步至最新
```
