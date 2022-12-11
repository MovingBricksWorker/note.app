
> 总结一下工作中常用到的一些可提升效率的一些AppleScript的操作 

<!-- * [关于AppleScript的一些应用总结](Mac技巧/关于AppleScript的一些应用总结.md)
* [为Mac自带的AppleScript脚本编辑器增加代码注释快捷键](Mac技巧/为Mac自带的AppleScript脚本编辑器增加代码注释快捷键.md)
* [关于AppleScript脚本语言的一些使用总结](Mac技巧/关于AppleScript脚本语言的一些使用总结.md) -->


## iTerm2 

### 在当前tab执行shell指令
```bash
tell application "iTerm"
		reopen
		activate
		tell the current window
			tell the current session
				write text "echo 'hello world !' "
			end tell
		end tell
	end tell
```
 
### 新建窗口并执行shell指令

```bash
tell application "iTerm"
    set myterm to create window with default profile
    tell myterm
        activate current session
        launch session "Default Session"
        tell the current session
            write text "echo hello"
            write text "clear;"
            write text "date && cal" without newline
        end tell
        write (sessions of current tab) text linefeed
    end tell
end tell
```



###  新建tab, 并执行shell命令

```bash
tell application "iTerm"
	tell current window
		create tab with default profile
		tell current session
			write text "echo 'hello world~ ' "
		end tell
	end tell
end tell
```



###  配合自动操作选中`Podfile`文件增加快速操作菜单,创建新窗口并执行pod install

![](https://cdn.jsdelivr.net/gh/WangGuibin/ImageBed@main/files/2022_01_11_19:54:00_Xnip2022-01-11_19-51-43.png)

```bash
#新建窗口,选中Podfile 右键快速操作找到pod install这个菜单执行即可
PodfilePath="${1%/*}" 
osascript <<EOF
tell application "iTerm"
    set myterm to create window with default profile
    tell myterm
        activate current session
        launch session "Default Session"
        tell the current session
            write text "cd ${PodfilePath}"
            write text "clear;"
            write text "pod install" without newline
        end tell
        write (sessions of current tab) text linefeed
    end tell
end tell
EOF

# 或者新建tab
PodfilePath="${1%/*}" 
osascript <<EOF
tell application "iTerm"
	tell current window
		create tab with default profile
		tell current session
            write text "cd ${PodfilePath}"
            write text "clear;"
            write text "pod install" without newline
		end tell
	end tell
end tell
EOF
```

## Safari

### 使用Safari打开指定URL

```bash
function openWebLink(){
osascript <<EOF
tell application "Safari"
	activate
    tell window 1
        set current tab to (make new tab with properties {URL:"${1}"})
    end tell
end tell
EOF
}
```

## Safari当前标签页执行一段js

```bash
//CSDN或360Doc解锁文本
tell application "Safari" to do JavaScript "javascript:window.oncontextmenu=document.oncontextmenu=document.oncopy=null; [...document.querySelectorAll('body')].forEach(dom => dom.outerHTML = dom.outerHTML); [...document.querySelectorAll('body, body *')].forEach(dom => {['onselect', 'onselectstart', 'onselectend', 'ondragstart', 'ondragend', 'oncontextmenu', 'oncopy'].forEach(ev => dom.removeAttribute(ev)); dom.style['user-select']='auto'; dom.style['-webkit-touch-callout']='auto'; dom.style['-webkit-user-select']='auto'; dom.style['-ms-user-select']='auto';dom.style['-khtml-user-select']='auto'; dom.style['-moz-user-select']='auto';});" in document 1

```

## Xcode

### Xcode打开/编译/运行项目的shell工作流

```bash
#! /bin/bash

WorkspaceName="xxx.xcworkspace" #workspace文件名
FilePath="/xxx/xxx" #项目根目录路径

#打开项目
function LoadProject() {
osascript <<SCRIPT
    tell application "Xcode"
#    判断已经打开就关闭的代码 觉着用不上就注释了
#        open "$FilePath"
#        set workspaceDocument to workspace document "${WorkspaceName}"
#
#        repeat 120 times
#            if loaded of workspaceDocument is true then
#                close workspaceDocument
#                exit repeat
#            end if
#        end repeat

        open "$FilePath"
        set workspaceDocument_new to workspace document "${WorkspaceName}"
        set loadTime_Begin to (current date)

        repeat 1200 times
            if loaded of workspaceDocument_new is true then
                set loadTime_End to (current date)
                exit repeat
            end if
        end repeat
    end tell
SCRIPT
}


# 编译项目
function BuildProject() {
osascript <<SCRIPT
    tell application "Xcode"
        set actionResult to build workspace document 1
        set buildTime_Begin to (current date)
        repeat
            if completed of actionResult is true then
                set buildTime_End to (current date)
                exit repeat
            end if
        end repeat
        log "Build 开始时间" & (time string of (buildTime_Begin))
        log "Build 开始结束" & (time string of (buildTime_End))
        log "Build 总共耗时 :" & (buildTime_End - buildTime_Begin) & "秒"
    end tell
SCRIPT
}

# 运行项目
function RunProject() {
osascript <<SCRIPT
    tell application "Xcode"
        set actionResult to run workspace document 1
        set runTime_Begin to (current date)
        repeat
            if status of actionResult is running then
                set runTime_End to (current date)
                exit repeat
            end if
        end repeat
        log "Run 开始时间" & (time string of (runTime_Begin))
        log "Run 开始结束" & (time string of (runTime_End))
        log "Run 总共耗时 :" & (runTime_End - runTime_Begin) & "秒"
    end tell
SCRIPT
}

LoadProject
BuildProject
RunProject
```
### Xcode打开的当前文件的路径
```bash
tell application "Xcode"
	set CurrentActiveDocument to document 1 whose name ends with (word -1 of (get name of window 1))
	set WhatYouWant to path of CurrentActiveDocument
end tell
```

##  Finder

### 获取当前选中文件或文件夹的路径
获取当前选中的文件或者文件夹的路径 (Mac 升级Big Sur之后Alfred快捷键就无法获取选中的文件或目录的路径,困扰了很长一段时间,后来无意中发现了这个操作,所以又算是修复了这个问题)
> 后来去Alfred官方论坛搜了一下 发现是权限问题,只要在 偏好设置>安全性与隐私>辅助功能里把Alfred勾选☑️上即可 可能是macOS big sur更注重隐私了
```bash
#! /bin/bash

# 获取当前选中的文件或者文件夹路径
CurrentSelectPath=$(osascript <<EOF
tell application "Finder"
    set theItems to selection
    set filePath to (POSIX path of (the selection as alias))
  end tell
  set q to filePath
  return q
EOF
)
echo $CurrentSelectPath

```
### AppleScript格式路径与POSIX路径互转
AppleScript获取的路径默认都是带冒号的,例如: `Macintosh HD:Applications:i4tools.app:`
`choose file`  或者 `choose folder` 可以获取带冒号的路径

带`:`的路径转为带`/`的路径
```bash
set appPath to POSIX path of "Macintosh HD:Applications:i4tools.app:"
# /Applications/i4tools.app
```
带`/`的路径转为带`:`的路径
```bash
set thePath to POSIX file "/Applications/i4tools.app" as string
# Macintosh HD:Applications:i4tools.app:
```

## 偏好设置
偏好设置的pane id可参考 [Mac 跳转系统偏好设置URL Scheme - 简书](https://www.jianshu.com/p/26253554a3f7)
打开安全性与隐私(安装第三方来源软件时往往要经常打开这个页面)  其实Alfred搜sec也可
```bash
tell application "System Preferences"
	activate
	set current pane to pane id "com.apple.preference.security"
end tell
```