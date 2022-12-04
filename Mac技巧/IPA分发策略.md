企业包   无设备限制,方便分发,需要手动信任证书

开发包   100个设备限制



- 手机 + Xcode  安装繁琐

- 内网 + cdn manifest.plist  => 行不通  手机无法访问内网

- 外网 + cdn manifest.plist   可行,但是服务器支持

- TrollStore 或者 AltStore  利用系统漏洞绕过系统签名进行安装 或者 免费的appleId进行7天内重签



`manifest.plist`格式如下: 需要放到`https`的资源服务器上 这里直接放github了, IPA放本地开个webServer 即可

通过`IPA`生成`manifest.plist`脚本如下: 
```bash
# /bin/bash
# $1 本地ipa文件路径
# $2 ipa服务端地址
# 用法 sh ipa2manifest.sh  /Users/WangGuibin/Desktop/App.ipa  http://10.161.62.123:8081/App.ipa
# $2 没传的话就得自己修改ipa的服务端文件地址了 不然plist取不到ipa啊
# 利用苹果的一个服务协议 放个a标签点击或者直接地址栏访问就行 <itms-services://?action=download-manifest&url=https://xxx/manifest.plist> 注意plist这个要https ipa的倒是无要求

zip_file=${1%.*}.zip
cp -R $1  $zip_file
unzip -o $zip_file > /dev/null 2>&1

#提取Info.plist的有用信息
info_plist=${1%/*}/Payload/*.app/Info.plist 
function getInfo(){
    /usr/libexec/PlistBuddy -c "print $1" $info_plist
}

AppName=$(getInfo "CFBundleDisplayName")
BundleId=$(getInfo "CFBundleIdentifier")
AppVersion=$(getInfo "CFBundleShortVersionString")

xmlText=$(cat <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>items</key>
	<array>
		<dict>
			<key>assets</key>
			<array>
				<dict>
					<key>kind</key>
					<string>software-package</string>
					<key>url</key>
					<string>${2}</string>
				</dict>
			</array>
			<key>metadata</key>
			<dict>
				<key>bundle-identifier</key>
				<string>${BundleId}</string>
				<key>bundle-version</key>
				<string>${AppVersion}</string>
				<key>kind</key>
				<string>software</string>
				<key>title</key>
				<string>${AppName}</string>
			</dict>
		</dict>
	</array>
</dict>
</plist>
EOF
)

echo $xmlText > ${1%/*}/manifest.plist 
rm -rf $zip_file
rm -rf ${1%/*}/Payload
```

文件格式如下:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>items</key>
	<array>
		<dict>
			<key>assets</key>
			<array>
				<dict>
					<key>kind</key>
					<string>software-package</string>
					<key>url</key>
					<!-- ipa文件资源所在地址 一般放内网 局域网访问资源文件快 一般ipa资源文件比较大 -->
					<string>http://192.168.201.111:8080/app.ipa</string>
				</dict>
			</array>
			<key>metadata</key>
			<dict>
				<key>bundle-identifier</key>
				<!-- bundleID -->
				<string>com.pingan.puhuiApp</string>
				<key>bundle-version</key>
				<string>2.1.4</string>
				<key>kind</key>
				<string>software</string>
				<key>title</key>
				<string>录屏demo</string>
			</dict>
		</dict>
	</array>
</dict>
</plist>
```

利用`itms-services`协议进行访问即可
```
itms-services://?action=download-manifest&url=manifest.plist的url
```

```
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>iOS 录屏Demo安装</title>
    <style>
      .rect {
        width: 200px;
        height: 200px;
        background-color: teal;
        border-radius: 50px;
      }
      #download {
        width: 200px;
        height: 50px;
        color: white;
        background-color: tomato;
        font-size: 25px;
        border-radius: 25px;
        box-shadow: 10px 10px 5px #888;
        padding: 10px;
        background-image: linear-gradient(to top right, red, orange);
        text-decoration: none;
      }
    </style>
  </head>
  <body>
    <div class="rect"></div>
    <div><p>录屏SDK演示Demo</p></div>
    <div id="app">
      <a
        id="download"
        href="itms-services://?action=download-manifest&url=https://cdn.jsdelivr.net/gh/WangGuibin/ImageBed@main/files/20220121160151.plist"
        >下载安装</a
      >
    </div>
  </body>
</html>
```

