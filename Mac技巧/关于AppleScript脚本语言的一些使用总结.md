<!-- * [关于AppleScript的一些应用总结](Mac技巧/关于AppleScript的一些应用总结.md)
* [为Mac自带的AppleScript脚本编辑器增加代码注释快捷键](Mac技巧/为Mac自带的AppleScript脚本编辑器增加代码注释快捷键.md)
* [关于AppleScript脚本语言的一些使用总结](Mac技巧/关于AppleScript脚本语言的一些使用总结.md) -->



## 1. 暗黑模式切换
```apl
tell application "System Events"
	tell appearance preferences
		set dark mode to not dark mode
	end tell
end tell
```

## 2. 发送邮件

```apl
--设置参数
set recipientName to "xxx" --收件人
set recipientAddress to "xxx@gmail.com" --收件地址
set mailSubject to "使用AppleScript脚本自动化发邮件" --邮件主题
set mailContent to "这是一封来自AppleScript发出的测试邮件,请勿回复!!!" --邮件内容

--执行发送邮件操作
tell application "Mail"
	
	--创建信息
	set theMessage to make new outgoing message with properties {subject:mailSubject, content:mailContent, visible:true}
	
	--发送信息
	tell theMessage
		make new to recipient with properties {name:recipientName, address:recipientAddress}

		send
		
	end tell
end tell
```

## 3. 弹窗相关

一个按钮默认样式
![一个按钮](https://cdn.jsdelivr.net/gh/WangGuibin/MyFilesRepo/images/btn1s.png)
一个按钮加空格格式化样式
![](https://cdn.jsdelivr.net/gh/WangGuibin/MyFilesRepo/images/btn1l.png)
两个按钮样式
![](https://cdn.jsdelivr.net/gh/WangGuibin/MyFilesRepo/images/btn2.png)
三个按钮样式
![](https://cdn.jsdelivr.net/gh/WangGuibin/MyFilesRepo/images/btn3.png)
没有icon样式 
![](https://cdn.jsdelivr.net/gh/WangGuibin/MyFilesRepo/images/Xnip2021-01-23_22-02-53.png)

反正这个dialog感觉就很安卓

#### a. 普通弹窗
```apl
display dialog "这是内容" with title "这是标题" --默认带上取消和确认按钮
--设置一个OK按钮以及默认选中
display dialog "这是内容" with title "这是标题" buttons "OK" default button "OK"
--效果同上
display dialog "这是内容" with title "这是标题" buttons "OK" default button 1
-- 自定义多个按钮 (最多允许使用三个按钮。)
display dialog "这是内容" with title "这是标题" buttons {"OK","Cancel","HAHA"} default button "OK"

```
或者alert 这个就比较iOS
![](https://cdn.jsdelivr.net/gh/WangGuibin/MyFilesRepo/images/alertl.png)

```apl
-- 与 dialog 类似布局上有所不同,按钮是居中纵向排列
display alert "hahhaha" buttons {"OK", "NO", "YES"} default button 2

```

#### b. 带图标的弹窗
```apl
--可以指定对话框的图标，icon 图标可以指定 note (普通) /stop (危险) /caution (警告) 三种类型 或者指向文件路径
display dialog "这是内容" with title "这是标题" buttons {"No", "Yes"} default button "Yes" with icon caution

-- 自定义图标 注意图片格式应该为.icns格式的 可以去应用xx.app/contens/resources下面去找
set fileName to choose file "Select a Folder"
display dialog "这是内容" with title "这是标题" buttons {"No", "Yes"} default button "Yes" with icon file fileName

-- 指定路径 桌面路径 + 文件名
display dialog "这是内容" with title "这是标题" buttons {"No", "Yes"} default button "Yes" with icon file ((path to desktop as text) & "AppIcon.icns")

-- 或者这样
display dialog "这是内容" with title "这是标题" buttons {"No", "Yes"} default button "Yes" with icon alias ((path to desktop as text) & "AppIcon.icns")
-- 转化一下
-- set fileName to ((path to desktop as text) & "AppIcon.icns")
set fileName to "Macintosh HD:Users:wangguibin:Desktop:AppIcon.icns"
display dialog "这是内容" with title "这是标题" buttons {"No", "Yes"} default button "Yes" with icon file fileName

-- 直接使用App Store的图标
set fileName to "Macintosh HD:System:Applications:App Store.app:Contents:Resources:AppIcon.icns"
display dialog "这是内容" with title "这是标题" buttons {"No", "Yes"} default button "Yes" with icon file fileName

```

#### c. 弹窗输入框表单
```apl
display dialog "表单" default answer "输入框内容" buttons {"按钮1", "按钮2", "按钮3"} default button 1 with icon caution
copy the result as list to {text_returned, button_pressed} --返回一个列表{文本,按钮}

```


#### d. 选择列表弹窗

![](https://cdn.jsdelivr.net/gh/WangGuibin/MyFilesRepo/images/selecScriptList.png)

```apl
-- 默认单选 默认不选中的话直接设置 `default items {}` 即可
choose from list {"Shell", "Ruby", "Python", "Applescript", "Javascript", "Perl", "Dart"} with title "日期选择" with prompt "选择一门脚本语言" OK button name "学习" cancel button name "放弃" default items {"Python"}

-- 多选
choose from list {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"} with title "日期选择" with prompt "选择一天或者多天" OK button name "确认选择" cancel button name "不选" default items {"Monday"} with multiple selections allowed

```

#### e. 选择文件和目录
选择文件
```apl
-- 选择文件 获取文件名 没有的话不会创建 只是返回一个路径 
choose file name with prompt "获取文件名"
```
选择目录
```apl
-- 注：其中prompt和default location参数同Choose File Name;另外invisibles指定显示隐藏 文件,multiple selections allowed可以多选,showing package contents显示包内容,省略时 则不显示隐藏文件/不可多选/不显示包内容
choose folder with prompt "选择目录" default location file "Macintosh HD:Users:mac:Desktop" with invisibles, multiple selections allowed and showing package contents
```

## 4. 通知

![](https://cdn.jsdelivr.net/gh/WangGuibin/MyFilesRepo/images/notepng.png)

```apl
-- 声音文件都在/System/Library/Sounds 
-- 其中Funk , Glass, Ping 这几种好听一些 
display notification "通知内容通知内容通知内容通知内容" with title "通知主标题" subtitle "副标题" sound name "Funk"
```


## 5. Shell 调用 AppleScript

适合简短的脚本语句
```bash
#注意单引号shell无法传参 如需传参则需要使用双引号\转义
osascript -e 'display notification "通知内容通知内容通知内容通知内容" with title "通知主标题" subtitle "副标题" sound name "Funk"'
```
适合多行脚本,增加可读性
```bash
#简单粗暴 直接使用重定向包含applescript语句即可
osascript <<EOF
set fileName to "Macintosh HD:System:Applications:App Store.app:Contents:Resources:AppIcon.icns"
display dialog "这是内容" with title "这是标题" buttons {"No", "Yes"} default button "Yes" with icon file fileName
set btn to (button returned of result)
get btn
EOF
# 返回值 "NO"或者"OK"
```
**更新于2021-01-26 20:50:50**
封装好了一个shell的自定义弹窗,可以把它当做是一个GUI工具,用于提示/提醒做交互
```bash
#!/bin/bash

# 1. 自定义通知消息 
# 传参 $1:消息描述 $2:通知标题 $3:通知副标题
function showNoteMessage(){
  osascript -e "display notification \"${1}\" with title \"${2}\" subtitle \"${3}\" sound name \"Funk\""
}
#test case:
#showNoteMessage "消息内容" "通知" "通知副标题"

# 2. 自定义弹窗(统一通用方法)
# 传参$1 弹窗消息内容
# 传参$2 弹窗标题
# 传参$3 按钮标题,多个用英文逗号隔开 
# 传参$4 默认选中的按钮标题或者按钮数字下标
# 传参$5 是否为输入框类型 传"0"或者"1" 默认"0"
# 传参$6 输入框默认占位内容,传不传无所谓,默认为空字符串 ""
# 传参$7 默认图标note/stop/caution 或者自定义文件路径(:格式路径可以通过choose file获取)  
# tips: 重要! 如果为输入框模式,那么输出结果就是{button returned:button,text returned:text} 否则只有按钮或者false 
function showCustomAlertMessage(){

if [[ -n "$4" ]]; then

	if [[ ${4} == *[!0-9]* ]]; then
     	defaultButton="default button \"${4}\""
     	else
     	defaultButton="default button ${4}"
	fi
else
	defaultButton=""
fi

#是否为输入框模式
if [[ "$5" = "1" ]]; then
	IS_InputMode="default answer \"${6}\""
	ReturnValue="get result"
else
	IS_InputMode=""
	ReturnValue="get the button returned of the result"
fi

if [[ -n "$7" ]]; then
  case ${7} in
	note)
	ICON="with icon note"
	;;
	stop)
	ICON="with icon stop"
	;;
	caution)
	ICON="with icon caution"
	;;
	*)
	ICON="with icon file \"${7}\""
	;;
 esac
else
 ICON="with icon file \"Macintosh HD:Applications:Xcode.app:Contents:Resources:Xcode.icns\""
fi

osascript <<EOF
	set buttonStr to "${3}"
	set oldDelimiters to AppleScript's text item delimiters
	set AppleScript's text item delimiters to ","
	set buttonList to every text item of buttonStr
	set AppleScript's text item delimiters to oldDelimiters
	get buttonList
	set btns to buttonList
	display dialog "${1}" with title "${2}" buttons btns ${IS_InputMode} ${defaultButton} ${ICON}
	${ReturnValue}  
EOF
}

# showCustomAlertMessage "弹窗消息内容" "弹窗标题" "按钮1,按钮2,按钮3" "按钮2"  "1" "占位内容" "note"
# showCustomAlertMessage "弹窗消息内容" "弹窗标题" "按钮1,按钮2,按钮3" "按钮2"  "0" "占位内容" "note"
#showCustomAlertMessage "弹窗消息内容" "弹窗标题" "按钮1,按钮2,按钮3" "按钮2" "0" "占位内容" "stop" 
#showCustomAlertMessage "弹窗消息内容" "弹窗标题" "按钮1,按钮2,按钮3" "按钮2" "0" "占位内容" "Macintosh HD:Applications:Xcode.app:Contents:Resources:Xcode.icns"

# 普通弹窗 一个ok就够了 就是一个确认的那种
function onlyConfirmButton(){
	showCustomAlertMessage "$1" "温馨提示" "好的" 1
} 
#onlyConfirmButton "登录成功!\n弹窗成功!"

# 多按钮弹窗 最多三个按钮 多了会报错
function mostButtons(){
	showCustomAlertMessage "$1" "温馨提示" "按钮1,按钮2,按钮3" "按钮3"
}
#mostButtons "最多只能定义三个按钮哦"

# 输入框弹窗
function showInputAlertMessage(){
	showCustomAlertMessage "$1" "$2" "取消,确认" 2 "1" ""
}
showInputAlertMessage "请输入密码" "登录验证"

```



## 6. AppleScript 调用 Shell 
do shell script + shell脚本语句即可
```apl
set shellStr to do shell script "cd ~/Desktop;cat shell_var.sh"
display alert shellStr buttons {"OK"}
```

## 总结

`AppleScript`配合`Shell` 以及`Alfred` 感觉能玩出很多花样来,一些工具确实能提升不少效率和体验。
 我平时玩的一些工具存放在这 [https://github.com/WangGuibin/WGBToolsConfigRepository](https://github.com/WangGuibin/WGBToolsConfigRepository)

## 参考博文文章
[applescript-快速入门](https://www.exchen.net/applescript-快速入门.html)
[我的新玩具-AppleScript(四)](https://blog.csdn.net/u011238639/article/details/56506056)
[applescript快速入门教程](https://www.cnblogs.com/itcomputer/p/10162392.html)
[AppleScript 脚本让 Mac 唱生日快乐歌](https://lucifr.com/make-your-mac-sing-happy-birthday-with-applescript/)