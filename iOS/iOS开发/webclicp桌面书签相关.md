这是一段描述文件源码,描述文件为.mobileconfig格式的文件,本质是xml

加上 `ConsentText`和`PayloadDescription`好像输入锁屏密码后会多出一个中间提示页面来

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>ConsentText</key>
	<dict>
		<key>default</key>
		<string>请点击右上角『下一步』按钮↗↗
  此乃输入密码之后的一个中间页 可以在这里加一些广告或者说明性的文字
  这个描述文件是根据苹果官方文档的格式生成的,不具备任何安全问题.
  请放心安装体验使用
  如果手机设置了锁屏密码，需要输入密码后才能继续安装。

</string>
	</dict>
	<key>HasRemovalPasscode</key>
	<false/>
	<key>PayloadContent</key>
	<array>
		<dict>
			<key>FullScreen</key>
			<true/>
			<key>Icon</key>
			<data>
			 图片的base64编码不需要格式声明前缀~
			</data>
			<key>IsRemovable</key>
			<false/>
			<key>Label</key>
			<string>百度一下</string>
			<key>PayloadDescription</key>
			<string>配置 Web Clip 設定</string>
			<key>PayloadDisplayName</key>
			<string>Web Clip</string>
			<key>PayloadIdentifier</key>
			<string>com.apple.webClip.managed.FF27417C-AA34-4F73-B2DA-823DAD1ADC57</string>
			<key>PayloadType</key>
			<string>com.apple.webClip.managed</string>
			<key>PayloadUUID</key>
			<string>EE55387C-BB23-4F73-B9DA-327DAD1ADC46</string>
			<key>PayloadVersion</key>
			<integer>1</integer>
			<key>Precomposed</key>
			<false/>
			<key>URL</key>
			<string>https://www.baidu.com</string>
		</dict>
	</array>
	<key>PayloadDescription</key>
	<string>请点击右上角『安装』按钮↗↗
   此乃描述文件之描述
  这个描述文件是根据苹果官方文档的格式生成的,不具备任何安全问题.
  请放心安装体验使用
  如果手机设置了锁屏密码，需要输入密码后才能继续安装。
</string>
	<key>PayloadDisplayName</key>
	<string>百度一下</string>
	<key>PayloadIdentifier</key>
	<string>vue-MacBook-Pro.02AFF61A-6426-428A-2E26-22D38F3D188A</string>
	<key>PayloadRemovalDisallowed</key>
	<false/>
	<key>PayloadType</key>
	<string>Configuration</string>
	<key>PayloadUUID</key>
	<string>DE2D6EAB-BAB2-4QA2-A07E-B738FC145F04</string>
	<key>PayloadVersion</key>
	<integer>1</integer>
</dict>
</plist>

```

具体可以参考[Webclicp在线生成工具](https://www.cnblogs.com/wgb1234/p/14969635.html) 
iOS 可以参考 [图标易容术](https://github.com/WangGuibin/WebClipChangeAppLogo)