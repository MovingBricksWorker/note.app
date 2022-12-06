# 我折腾的shell笔记
* [Mac一些常用的快捷键记录](#mac一些常用的快捷键记录)
    * [iTerm2或者命令行相关](#iterm2或者命令行相关)
    * [Mac桌面上或者某目录下操作](#mac桌面上或者某目录下操作)
* [一些实用脚本示例](#一些实用脚本示例)
    * [代码无提示或者其他抽风症状,清除Xcode缓存](#代码无提示或者其他抽风症状清除xcode缓存)
    * [查看当前网络ip地址](#查看当前网络ip地址)
    * [日常提交推送git代码](#日常提交推送git代码)
    * [统计iOS代码行数](#统计ios代码行数)
    * [Plistbuddy相关的操作](#plistbuddy相关的操作)
* [修改终端欢迎页面](#修改终端欢迎页面)
* [oh-my-zsh的agnoster的主题配置需要注意的几个问题](#oh-my-zsh的agnoster的主题配置需要注意的几个问题)

[shell 代码集合](https://github.com/WangGuibin/WGBToolsConfigRepository/blob/master/Shell/README.md)

## Mac一些常用的快捷键记录

###  iTerm2或者命令行相关
|                                |            |
|------------------------------------  | ------------------ |
| `ctrl + d`                           | 删除当前光标的字符 |
| `ctrl + h`                           | 删除光标之前的字符 |
| `ctrl + w`                           | 按单词(`word`)单步删除输入的命令 |
| `ctrl + a`                           | 光标移动到行首        |
| `ctrl + e`                           | 光标移动到行尾        |
| `ctrl + f/b`                           | 前进后退： (相当于左右方向键)        |
| `ctrl + p`                           | 上一条命令      |
| `ctrl + r`                           | 搜索命令历史      |
| `ctrl + t`                           | 交换光标处文本   |
| `ctrl + k`                           | 删除到文本末尾    |
| `⌘ + r` 或 `ctrl + l`          | 清屏(`⌘ + r` = `clear`，而且只是换到新一屏，不会想 `clear` 一样创建一个空屏)   |
| `ctrl + q` , `ctrl + u` | 清除输入的命令行当前行           |
| `open ./`                            | 弹出当前目录`finder`     |
| `⌘ + t`                            | 新建标签页     |
| `⌘ + w`                            | 关闭标签页     |
| `⌘ + 数字` 或 `⌘ + 左右方向键`  | 切换标签页     |
| `⌘ + enter`                        | 切换全屏     |
| `⌘ + f`                            | 查找     		 |
| `⌘ + d`                            | 垂直分屏    		 |
| `⌘ + shift + d`                    | 水平分屏     		 |
| `⌘ + option + 方向键`或 `⌘ + [` 或 `⌘ + ]`| 切换屏幕  |
| `⌘ + ;`                            |查看历史命令     		 |
| `⌘ + shift + h`                    | 查看剪贴板历史 		 |
| `⌘ + f`                            | 查找     		 |


### Mac桌面上或者某目录下操作
* `⌘ + shift + G` 前往文件夹
* `⌘ + space` 聚焦搜索即全局搜索
* `⌘ + shift + .` 隐藏/显示隐藏文件或文件夹
* `⌘ + shift + 3` 全屏截图  
* `⌘ + shift + 4` 可选取范围截图
* `ctrl + ⌘ + space` 弹出`emoji`选择窗口
* `ctrl + ←` 向左切换桌面
* `ctrl + →` 向右切换桌面
* `ctrl + ↑` 显示全部桌面选择
* `ctrl + ↓` 显示最近打开编辑过的文件
* `⌘ + tab` 切换已打开程序坞上的应用
* `⌘ + q` 关闭当前程序
* `⌘ + w` 关闭当前窗口
* `⌘ + n` 新建文件
* `⌘ + s` 保存
* `⌘ + ,` 当前应用的偏好设置
* `ctrl + space` 切换输入法


## 一些实用脚本示例

### 代码无提示或者其他抽风症状,清除Xcode缓存
```shell
#!/bin/bash
defaults write com.apple.dt.XCode IDEIndexDisable 0
rm -rf ~/Library/Developer/Xcode/DerivedData
rm -rf ~/Library/Caches/com.apple.dt.Xcode
# 关闭Xcode 
killall Xcode
```
### 查看当前网络ip地址
```shell
#!/bin/bash
curl ip.sb
```
### 日常提交推送git代码
```shell
#!/bin/bash

read -p "输入提交日志信息: " commit_message
read -p "输入分支名(默认为dev分支): " branch_name

if [[ -n "${commit_message}" ]]; then
	#statements
	echo "日志信息参数为: ${commit_message}"
else
	echo "日志信息参数为空，已使用默认模板: 🚀update~"
	commit_message="🚀update~"
fi

if [[ -n "${branch_name}" ]]; then
	#statements
	echo "分支名参数为: ${branch_name}"
else
	echo "分支名参数未输入,默认为dev"
	branch_name="dev"
fi

git add .
git commit -am  "${commit_message}"
git push origin ${branch_name}
```

### 统计iOS代码行数
```shell
#!/bin/bash
	read -p "输入代码文件所在路径: " code_path
	find ${code_path} "(" -name "*.h" -or -name "*.mm" -or -name "*.m" -or -name "*.swift" ")" -print | xargs wc -l 

```

### `Plistbuddy`相关的操作

* 添加`name`字段 值为`iqiyi`
```shell
plistbuddy -c 'Add :items:0:metadata:name string "iqiyi"' ~/Desktop/man.plist
```

* 修改`title`值为`你好`
```shell
plistbuddy -c 'Set :items:0:metadata:title "你好"' ~/Desktop/man.plist
```

* 删除`name`字段
```shell
plistbuddy -c 'Delete :items:0:metadata:name ' ~/Desktop/man.plist
```

* 合并两个`plist` 可设置层级
```shell
PlistBuddy -c 'Merge A.plist' B.plist
plistbuddy -c "Merge ~/Desktop/Global.plist :Software:Gallery"~/Desktop/man.plist
```
* 打印

```shell
plistbuddy -c 'Print' ~/Desktop/man.plist
```

##  修改终端欢迎页面
```shell
# 无论是linux还是Mac,终端都有这么一个配置文件,专门设置初始页面的展示,可以自由发挥(写上自己的大名或者画一张ascii图佛祖保佑永无bug之类的,座右铭啥的...)
vim /etc/motd
```
##  `oh-my-zsh`的`agnoster`的主题配置需要注意的几个问题

```shell
#agnoster主题,zsh默认目录是不带颜色的,在.zshrc末尾加上即可
export LSCOLORS="exfxcxdxbxexexabagacad"

# 修改终端路径前缀,默认为电脑用户名,可以在~/.oh-my-zsh/themes/agnoster.zsh-theme修改prompt_context函数或者将其调用注释即可缩短路径长度

prompt_context() {
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    # prompt_segment black default "%(!.%{%F{yellow}%}.)$USER@%m"
    prompt_segment red default "🎯Coding"
  fi
}

# 改变路径显示颜色和缩减路径长度
prompt_dir() {
  #prompt_segment blue black '%~' #默认显示全路径
   prompt_segment 3 white '%c' #只显示当前路径
}

# 还有有git管理的目录下的路径颜色显示也可以改prompt_git函数
 
 if [[ -n $dirty ]]; then
      #prompt_segment yellow black
      prompt_segment yellow white
    else
      #prompt_segment green black
      prompt_segment green  white
    fi

```