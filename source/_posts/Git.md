---
title: git 操作记录
tags: 笔记
categories: Git
abbrlink: fc40f442
date: 2020-01-06 00:00:00
updated: 2020-01-06 00:00:00
---

# Git

初始化Git

```shell
git init
```

查看被托管的文件

```shell
git status
```

托管文件

```shel
git add . # 点就代表所有文件，
```

第一次复制

```shell
git commit -m '名称'
```

文件检测到，需要重新提交

查看修改日志

```shell
git log
```

回到第一次提交状态，本地文件会回滚gitgit

``` 
git reset --hard # + 第一次 commit 后面的内容或者 reflog 后面的内容
```

查看以前的状态：

```shell
git reflog
```



上线：

1.git 删除远程地址

git remote rm origin
2.git 更换远程地址

 git remote add origin http://10.00.3.260:10080/xxxxxx/sxxxy.git/
3.把当前分支与远程分支进行关联(branchname要改成你的当前分支名称)

git push --set-upstream origin branchname

接下来，我们就要开始配置了。

通过 `git remote add <name> <url-of-remote>` 指令来添加远程仓库。

> name 是远程仓库的别名，便于区分不同的远程仓库。

> url-of-remote 是我们的远程仓库链接，就是平时看到的以.git为后缀的链接啦！

比如，我想添加github的远程仓库，并且取名为 github：

```
git remote add github https://github.com/gongqingfeng/Drcom.git
```

至于链接来自于哪，这里就不用我多说了吧！添加码云的远程仓库也是类似的操作，因为我前面假设的是clone自码云，所有这里就不需要添加了。

好，来看一下我们刚刚添加好的仓库：

```
git remote -v
```

这条指令就是用来查看远程仓库的。

强制推送

```
git push origin master -f
```