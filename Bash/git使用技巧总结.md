# git使用技巧总结
* [介绍](#介绍)
* [git rebase](#git-rebase)
* [git merge](#git-merge)
* [git pull：相当于是从远程获取最新版本并merge到本地](#git-pull相当于是从远程获取最新版本并merge到本地)
* [分支管理](#分支管理)
* [tag管理](#tag管理)
* [代码回滚](#代码回滚)
* [生成SSH-Key](#生成ssh-key)
* [配置用户名和邮箱等信息](#配置用户名和邮箱等信息)
* [本地库关联远程库](#本地库关联远程库)
* [git解决每次拉取代码都需要用户名密码](#git解决每次拉取代码都需要用户名密码)
* [公司搭建的git如何拉取代码?](#公司搭建的git如何拉取代码)
* [查看终端oh-my-zsh工具封装的git快捷命令](#查看终端oh-my-zsh工具封装的git快捷命令)

## 介绍
随着开发流程的推进,项目的不断迭代,各种版本库的代码管理显得尤为重要,而本文记载的是关于我在Git使用过程中所遇到过的各种问题。
只要遇到新的问题,本文会持续更新。 


##  git rebase  
开分支 ->  各自开发不同的模块 -> 合并代码的时候,先提交自己的分支然后`rebase`自己的分支到`master`最新的部分 
`rebase`谁就是把谁当作自己的基点,然后把自己的提交跟在后面,`rebase`完后再切换到`maser`, `master`再`rebase`自己的开发的功能分支,
完事之后可以打个`tag`，让分支滚蛋  
```shell
在dev分支 -> rebase主分支master最新的主干代码
切到master主分支 -> rebase到最新代码 -> 卸磨杀驴移除分支 

```
[在开发过程中使用git rebase还是git merge，优缺点分别是什么？](https://www.zhihu.com/question/36509119?rf=26492099)

##  git merge  

`git merge b `      *将`b`分支合并到当前分支*
同样 `git rebase b`，也是把 `b`分支合并到当前分支

主要看当前所在的分支, merge谁就合并谁  合并的意思是重复的不管 加入没有的,还有就是原本存在的被改了会被覆盖以及冲突

https://www.cnblogs.com/marblemm/p/7161614.html


```shell
git fetch origin master:tmp
git diff tmp 
git merge tmp
git branch -d tmp
```
从远程获取最新的版本到本地的`tmp`分支上,之后再进行比较合并

##  git pull：相当于是从远程获取最新版本并merge到本地 

```shell 
git pull origin master
上述命令其实相当于git fetch 和 git merge
在实际使用中，git fetch更安全一些
因为在merge前，我们可以查看更新情况，然后再决定是否合并

gfo master ：temp
gd temp 比較 
gm temp 合并遠程分支
gbd “temp” 刪掉臨時分支
```

##  分支管理 
 
-----

|  只创建分支  | git branch branchName                                        |
| :----------: | :----------------------------------------------------------- |
|  只切换分支  | `git checkout branchName` 或者 <br/> `git switch branchName`       |
|  创建并切换  | `git checkout -b branchName` 或者<br/> `git switch -c branchName` |
| 删除本地分支 | `git branch -D branchName` 或者<br/> `git branch -d branchName`  |
| 删除远程分支 | `git push origin --delete branchName` 或者<br/> `git branch -r -d origin/dev && git push origin :dev` 或者<br/> `git push origin -d <branch name>` 其中<br/> `git push origin :branchName` 原型是 `git push origin master:branchName` <br/>将本地的`master`分支推送到远程的`branchName` |
| 查看所有分支 | `git branch`                                                 |
|   合并分支   | `git merge branchName` 一般是切换到主分支(`master`)把旁分支(`branchName`)合并 或者<br/>使用 `git merge branchName -m "xxx" --no-ff` 其中`--no-ff` <br/>Git默认会用`Fast forward`模式，但这种模式下，删除分支后，<br/>会丢掉分支信息,强制禁用`Fast forward`模式，<br/>加上`--no-ff`就可以查看完整的分支历史信息，不受分支删除影响。 |


##  tag管理 
```shell
git tag #查看已有tag
git tag tagName #当前分支最新节点的tag
# 指定节点打tag并添加release note信息  
git tag -a v0.1 -m "version 0.1 released" 1094adb
git tag -d <tagname> #删除本地标签
git show <tagname> #可以看到说明文字：
git push origin v1.0 #推送指定本地标签
git push origin --tags #一次性全部推
git push origin :refs/tags/v0.9 #删除指定的远程标签
git push origin :<branch>/<tag> #删除指定的远程标签 注意冒号 : 必不可少, 后面跟远程库的分支名/标签名

```

##  代码回滚
```shell
# 回滚上一个版本,回滚到上上个则 HEAD^^,以此类推往回滚100次则很难数得清楚^的个数可以写成 HEAD~100 这样
git reset --hard HEAD^   
# 常用的是这种指定commit_id切换
git reset --hard a2bcke52 
```
撤销修改
```shell
场景1：当你改乱了工作区某个文件的内容，想直接丢弃工作区的修改时，用命令git checkout -- file。

场景2：当你不但改乱了工作区某个文件的内容，还添加到了暂存区时，想丢弃修改，分两步，第一步用命令git reset HEAD file，就回到了场景1，第二步按场景1操作。

场景3：已经提交了不合适的修改到版本库时，想要撤销本次提交，参考版本回退一节，不过前提是没有推送到远程库

场景4: 就是把错误的改动已经推送到远程库了,如何撤回呢? 
分两个情况处理: 

本地: 
本地节点代码回滚或者撤回最近一次提交重新修改之后`git  commit --amend`即可,
本地不会生成一条新的提交记录,而是覆盖原来的提交记录. 也可以使用回滚的方式 git reset --soft  HEAD^ 回滚到上一个节点,
如果改动的东西比较多还是--amend靠谱些,或者也先把代码拷出来一份然后再使用reset,最后把新增的部分代码手动加进去(这样贼麻烦)  

远程:
 已经推送到远程的处理,与他人合作的话切记第一时间沟通好(免得造成事故),远程没得选,只能强推干掉记录 git push -u origin --force branchName 
除非公司或者团队已经搭建好提交代码合并代码的规范流程,在自己分支上随便你怎么玩,多人合作主分支的话就略显尴尬(--force慎用 (逃

```
##  生成SSH-Key

```shell
#1. 检查是否有ssh key
 cd ~/.ssh 查看这个目录下的文件
 #2. 生成key
 ssh-keygen -t rsa -C "you email@email.com" 或者去掉 －t rsa
 #3. 拷贝公钥,设置好对应的key github或者使用的站点
 cat ~/.ssh/id_rsa.pub  查看并拷贝到到git添加设置key
#或者用命令添加到剪贴板
pbcopy < ~/.ssh/id_rsa.pub
#4. 测试一下这个ssh能不能使用
ssh -T git@github.com
``` 
##  配置用户名和邮箱等信息
```shell
# 一般全局设置 
git config --global user.name  "username"  
git config --global user.email  "email"

# 针对单个仓库设置 去掉 --global ,在项目.git目录下找到.git/config文件直接修改
(偶尔一台电脑可能有多个github账号使用,发现上传不了代码也可在config文件直接添加用户名邮箱来指定)
[user]
	name = 要设置的username
	email = 要设置的email
或者执行如下语句:
git config  user.name  "username"  
git config  user.email  "email"

# 最后查看配置列表
git config --list
``` 
##  本地库关联远程库
`一般操作: 远程创建一个仓库,然后拉下来一个文件夹,在文件夹中增删改一些操作`
**可能的情况:**
> 1. 本地已经是已存在的git仓库,但并没有与远程库关联
> 2. 本地还没创建git,更别提什么远程库了

```shell
如果本地没有git管理,先本地库git初始化
git init
git add .
git commit -m"log message"
如果已存在或者已经创建好本地git,则:(这里是ssh)
git remote add origin git@github.com:WangGuibin/TestDemo.git
没报错则说明关联成功
git pull 拉下来
然后rebase或者git reset --hard commitid移动到正确的位置
然后再把本地的东西提交上去
```

##   git解决每次拉取代码都需要用户名密码
 > 1. 执行`git config --global credential.helper store`，在`~/.git/config`目录下会生成一个配置文件(全局的)，这里会记录你的密码和帐号,再执行`git pull `输入一次正确的帐号密码之后就不用再痛苦重复输密码这件事了.
 > 2. 使用`ssh-key`绑定的形式,无论是`gitlab`还是`gitblit`应该都支持绑定的,只要绑定了基本不用输密码的操作

## 公司搭建的`git`如何拉取代码?
```shell
# 组成结构是 协议头 + 用户名:密码@域名
 git clone https://{username}:{password}@github.com
```

##  查看终端`oh-my-zsh`工具封装的git快捷命令
```shell
alias | grep git
```