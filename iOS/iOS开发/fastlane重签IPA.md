1.把要重签名的ipa包和描述文件放到同一个文件夹

2.终端cd到该文件夹

3.终端执行下面命令，回车

```bash
fastlane sigh resign
```
不过这种方式会强行修改bundleId为描述文件的bundleId

4.在证书列表选择要签名的证书，复制到终端，回车

5.等待重签名成功，会替换文件夹里的ipa

然后真机连上Xcode进行安装即可 


安装一个轻松签(重签可以修改bundleId),开发者账号创建一个通配符的bundleId,为了保证bundleId不重复可以多次使用这个描述文件
