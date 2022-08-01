## 注册 Github 账号

如果你没有 Github 账号，访问 [Github](https://github.com) 官网注册

并将公司邮箱 `your.username@gravit.com` 添加到 Github 邮箱列表中：

{F111409, size=full}

## Git 初始化

Git 是通用的代码版本管理工具

```
lang=bash
# 配置姓名和邮箱（将以下命令中的姓名和邮箱替换为自己的）
git config --global user.name "your.username"
git config --global user.email your.username@graviti.com

# 也可以根据不同的代码仓库进行局部配置
git config --local user.name "your.username"
git config --local user.email your.username@graviti.com
```

NOTE: `user.email` 需要使用 `.com` 的邮箱，`user.name` 配置为 phabricator 用户名，与邮箱前缀相同

```
lang=bash
# 配置默认push方法为simple
git config --global push.default simple
```

```
lang=bash
# 配置git pull时默认使用rebase
git config --global pull.rebase true
```

小技巧：[MacOS Git 补全设置](https://phabricator.graviti.cn/w/graviti_blogs/macos/git命令补全/)

## 生成 SSH key

```
lang=bash
# 查看系统ssh公钥
cat ~/.ssh/id_rsa.pub
```

```
lang=bash
# 若文件不存在，则通过以下命令生成（将邮箱替换为自己的），执行命令后一路回车即可
ssh-keygen -t rsa -C "your.username@graviti.cn" -b 4096

# 生成之后重新查看
cat ~/.ssh/id_rsa.pub

# 复制该文件内所有内容
```

## 配置 Github SSH key

{F111413, size=full}
{F111418, size=full}

## 默认编辑器

`git` 的默认编辑器为`nano`
可以通过以下命令修改默认编辑器

```
lang=bash
git config --global core.editor <editor_name>
```


很多小伙伴抱怨MacOS上的git不能进行补全，
这篇blog帮你解决问题

#### 1. 安装`bash-completion` + 重新安装`git`

```
lang=bash
brew install bash-completion git
```

#### 2. 将以下内容添加到你的`~/.bash_profile`中
```
lang=bash
[ -r /usr/local/etc/profile.d/bash_completion.sh ] && \
    source /usr/local/etc/profile.d/bash_completion.sh
function _expand() { :;}
```

#### 3. 运行以下命令或者重启终端使补全生效
```
lang=bash
source ~/.bash_profile
```
