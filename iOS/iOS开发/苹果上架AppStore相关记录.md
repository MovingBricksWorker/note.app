
1. 需要申请一个开发者账号,无论是个人或者是公司(得走申请邓白氏麻烦些)的都行,`99美刀`好多年了还是这个价,这很苹果

2. 创建证书,发布证书和开发证书(如果有远程推送功能还得创建一套推送证书),需要在钥匙串创建一个`CSR` (从证书颁发机构请求证书)创建这样一个文件作为证书的一个秘钥,创建证书的时候需要上传`CSR`才能生成证书,生成之后下载证书到本地,本地电脑才能识别验证, 然后别人电脑上需要使用你这个证书(无论是发布还是开发证书)的话,得导出对应的`P12`分享过去,导出的时候会让设置一个密码,对方打开`P12`的时候会做一个验证,验证成功就能使用了, 其次就是描述文件,光有证书还是不够的,还得有能识别设备的描述文件才能跑真机设备,所以一般导出`P12`和描述文件是一套的操作流程~

3. 新建`AppId`,尾巴上拼`App`的`bundleId`,当然也可以是通配符比如`Xcode`默认生成的那个就是通用的

4. 添加`UDID`设备唯一码,开发证书打的包需要安装的话就必须生成包含设备`UDID`的描述文件进行打包才行,不然无法安装

5. 打包方式很多,开发包,`adhoc`,`Testflight`,还有企业包,都需要用到不同的证书


6. `ITunes Connect` 新建App , 添加应用基本信息,描述文案,关键词,隐私政策等

7. 如果有内购还得签协议,绑定银行卡瓜分苹果税,新建内购项目,沙盒测试等



#### 4.3大礼包

```objc

Guideline 4.3 - Design

We noticed that your app provides the same feature set as other apps submitted to the App Store; it simply varies in content or language, which is considered a form of spam.

The next submission of this app may require a longer review time.

Next Steps

- Review the Design section of the App Store Review Guidelines.
- Ensure your app is compliant with all sections of the App Store Review Guidelines and the Terms & Conditions of the Apple Developer Program. 
- Once your app is fully compliant, resubmit your app for review.

When creating multiple apps where content is the only varying element, you should offer a single app to deliver differing content to customers. If you would like to offer this content for purchase, it would be appropriate to use the in-app purchase API.

Alternatively, you may consider creating a web app, which looks and behaves similar to a native app when the customer adds it to their Home screen. Refer to the Configuring Web Applications section of the Safari Web Content Guide for more information.

Submitting apps designed to mislead or harm customers or evade the review process may result in the termination of your Apple Developer Program account. Review the Terms & Conditions of the Apple Developer Program to learn more about our policies regarding termination.

```

应对策略:

1. 防止机审发现代码重复率,可修改类名前缀 和 方法名,其实最好的效果是混淆,但是市面上有效的混淆工具都收费不菲,项目代码量庞大,人工手动修改不现实
2. 资源文件修改hash值, `brew install imagemagick` 项目根目录下执行 `find . -iname "*.png" -exec echo {} \; -exec convert {} -quality 99 {} \;`,如果不对比文件名的话,应该是对比文件hash,这只是猜测,最好的效果是都进行修改,资源文件数量大的话也是让老板加钱加人


[代码混淆参考念茜这篇文章](https://blog.csdn.net/yiyaaixuexi/article/details/29201699)
[实践混淆的例子](https://www.jianshu.com/p/0d42e5c6361c)