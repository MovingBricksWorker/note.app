#### 根据脚手架创建lib库
```bash
pod spec create DemoLib

```

#### Spec文件编写
可参考各大流行三方库 
也可参考此库 https://gitee.com/wangguibin/wgbtool-kit

```ruby
Pod::Spec.new do |s|
  s.name             = 'WGBToolKit'
  s.version          = '0.1.1'
  s.summary          = 'WGBToolKit就是一个工具类库,封装了一些常用的工具'

  s.description      = <<-DESC
WGBToolKit就是一个工具类库,封装了一些常用的工具,为了快速开发,用自己称手的工具
                       DESC

  s.homepage         = 'https://gitee.com/wangguibin/wgbtool-kit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'CoderWGB' => '864562082@qq.com' }
  s.source           = { :git => 'https://gitee.com/wangguibin/wgbtool-kit', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.requires_arc = true

  #s.prefix_header_file = 'WGBToolKit/WGBToolKit.h'
  s.source_files = 'WGBToolKit/WGBToolKit.h' #配置个头文件 统一入口引入 
  s.frameworks = 'UIKit', 'Foundation' #基础系统库


  s.subspec 'DebugTool' do |ss|
   #分子模块可以按需安装 不必把整个库集成进去
    ss.source_files = 'WGBToolKit/DebugTool/WGBDebugTool.h'
    #InjectionIIIHelper 热重载插件 搭配腾讯的lookin提升模拟器调试UI体验
    ss.subspec 'InjectionIIIHelper' do |sss|
      sss.source_files = 'WGBToolKit/DebugTool/InjectionIIIHelper/*.{h,m}'
    end
  end

  #UIKit相关工具类或组件
  s.subspec 'UIKit' do |ss|
    uikits = Array['UIButton','UIColor'] #目录结构组成比较简单的且有规律的饭数组遍历了 这样简单些
    for uikit in uikits
      ss.subspec uikit do |sss|
        sss.source_files = 'WGBToolKit/UIKit/' + uikit + '/*.{h,m}'
      end
    end
#    #UIButton相关
#    ss.subspec 'UIButton' do |sss|
#      sss.source_files = 'WGBToolKit/UIKit/UIButton/*.{h,m}'
#    end
  end

  #Foundation相关工具或组件
  s.subspec 'Foundation' do |ss|
      foundations = Array['NSArray','NSDictionary','NSObject'] #有新的模块可以在数组里追加 注意目录摆放就是了
      for  subModuleName in foundations
        ss.subspec subModuleName  do |sss|
          sss.source_files = 'WGBToolKit/Foundation/' + subModuleName + '/*.{h,m}'
        end
      end
  end


  # s.subspec 'pb' do |pbspec|
  #       pbspec.source_files = 'SDK/Services/pb/*.{m,mm,h}'
  #       pbspec.requires_arc = false #局部mrc
  # end
  # s.source_files = 'WGBToolKit/Classes/**/*' #挑选作为库文件
  # s.resource_bundles = {   # bundle资源 会生成一个WGBToolKit.bundle 
  #   'WGBToolKit' => ['WGBToolKit/Assets/*.png']
  # }
  #s.resources = 'SDK/xxx/Service/**/*.{xib}' #资源文件会放到mainBundle里
  #  ss.vendored_libraries = 'HMApplePaySDK/libs/libUPAPayPlugin.a' #静态库
  # ss.public_header_files = 'HMApplePaySDK/inc/*.h' #静态库的头文件
  #s.vendored_frameworks = 'SDK/Tencent/GMESDK.framework' # 依赖的私有framework
  # s.public_header_files = 'Pod/Classes/**/*.h' 
  # s.dependency 'FMDB', '2.7.5'
  # s.dependency 'AFNetworking', '~> 2.3' #依赖只能依赖同源的库 如果有不同源的库 fork到私有源管理即可
end

```


#### 私库

```bash
pod repo add MySpec https://xxx.com/CoderWGB/WGBSpec.git
#   pod它会在~/cocoapods/repos目录下管理这个仓库
pod repo push MySpec WGBCustomAlertPopupView.podspec  --allow-warnings

#Podfile集成使用时 就可以使用MySpec这个源了
source "https://xxx.com/CoderWGB/WGBSpec.git" 
platform :ios,'11.0'
target "WGB_MyDemoApp" do
pod 'WGBCustomAlertPopupView','0.0.1'
end

```
?> TIPS: pod指定git仓库分支节点拉取库的方式
> 1. 指定分支：通过在 Git URL 后添加 #:branch 的方式来指定特定的分支。例如：pod 'MyLibrary', :git => 'https://github.com/username/MyLibrary.git#:develop'  或者 pod 'Alamofire', :git => 'https://github.com/Alamofire/Alamofire.git', :branch => 'dev'   将从名为 develop 的分支中获取代码。
> 2. 指定提交节点：通过在 Git URL 后添加 @SHA 的方式来指定特定的提交节点。例如：pod 'MyLibrary', :git => 'https://github.com/username/MyLibrary.git@1234567890abcdef' 将从提交节点为 1234567890abcdef 的代码版本中获取代码。
> 3. 指定tag  pod 'MyLibrary', :git => 'https://github.com/username/MyLibrary.git, :tag => '3.1.1'
> 4. 指定commitId  pod 'Alamofire', :git => 'https://github.com/Alamofire/Alamofire.git', :commit => '0f506b1c45'



根据提示,按步骤走下来就可以生成一个模板工程
只需要把库文件和资源放到Class和Assets目录下即可

然后需要git管理提交并打上tag才能开始操作pod远程库相关的制作

本地库的话就不用这么麻烦,直接放项目目录下进行引用即可,主要还是.podspc文件的编写

本地库spec填写完毕之后 git提交并打包之后创建一个远程库进行关联
```
git remote add origin https://gitee.com/wangguibin/xxx.git
#关联成功之后直接推送 或者加个参数 -f 强推

```

#### lint 校验
一般来说本地库不需要校验也行,校验纯属是规范操作
```bash
#公有库
pod spec lint --use-libraries --allow-warnings --verbose
# 私有库
# pod spec lint WeexSDK.podspec --sources='http://git.dddfsfsfsfpecs.git,https://github.com/CocoaPods/Specs.git' --allow-warnings --use-libraries
``` 
lint报错的话可能来回提交修改,也许能用上以下这个脚本
```bash
#一个tag可能有错，多次修改后，删除之前的tag,把最新的做为此tag
# sh updateLastTag.sh  

# 拉取分支上现有的tags
git fetch --tags
#获取最新版本tag
LatestTag=$(git describe --tags `git rev-list --tags --max-count=1`)

# 提交缓存区
git add .
# 提交本地仓库，提交说明
git commit -m "updateLastTag ${LatestTag}"
# 提交到远程
git push origin

#在本地删除老的最新的tag
git tag -d ${LatestTag}
#在远程删除老的最新的tag
git push origin --delete $LatestTag
#将最新提交的commit作为tag标记在本地
git tag ${LatestTag}
#将最新提交的commit作为tag标记在远程
git push origin ${LatestTag}

```

##### lint成功之后就可以推送到私有源管理

```
# 提示 xxx.podspec passed validation.即可
pod spec lint --use-libraries --allow-warnings 
# push
pod repo push MyPodSpecs WGBToolKit.podspec --allow-warnings
#提示 - [Add] WGBToolKit (0.1.0)   Pushing the `MyPodSpecs' repo 说明成功了 一般这个步骤很少失败 毕竟私有库没有那么严格

```


#### 更新版本 

```bash
# 拉取分支上现有的tags
git fetch --tags
#获取最新版本tag
LatestTag=$(git describe --tags `git rev-list --tags --max-count=1`)
# 修改为新version
sed -i "" s/${LatestTag}/$1/g ./basePod.podspec
# 提交缓存区
git add .
# 提交本地仓库，提交说明
git commit -m "addNewVersion $1"
# 提交到远程
git push origin

#将最新提交的commit作为tag标记在本地
git tag $1
#将最新提交的commit作为tag标记在远程
git push origin $1
```


#### 推送至远端

```bash
# 公有库
pod trunk push xxx.podspec  --allow-warnings

# 私有库
# pod repo push MySpecs xxx.podspec --allow-warnings

# 注册
# pod trunk register xxx@qq.com  JackMark

```





#### CocoaPods: pod search 搜索类库失败的解决办法

执行pod search来搜索类库信息时，却总是`[!] Unable to find a pod with name, author, summary, or descriptionmatching '
* 执行pod setup 
其实在你安装CocoaPods执行pod install时，系统会默认操作pod setup，然而由于中国强大的墙可能会pod setup不成功。这时就需要手动执行pod setup指令，如下： 
终端输入：pod setup 
会出现Setting up CocoaPods master repo，稍等几十秒，最底下会输出Setup completed。说明执行pod setup成功。
* 如果pod search操作还是搜索失败，如下： 
终端输入：pod search AFNetworking 
输出：Unable to find a pod with name, author, summary, or descriptionmatching 'AFNetworking' 这时就需要继续下面的步骤了。 
删除~/Library/Caches/CocoaPods目录下的search_index.json文件 
pod setup成功后，依然不能pod search，是因为之前你执行pod search生成了search_index.json，此时需要删掉。 
终端输入：rm ~/Library/Caches/CocoaPods/search_index.json 
删除成功后，再执行pod search。
* 执行pod search 
终端输入：pod search afnetworking(不区分大小写) 
输出：Creating search index for spec repo 'master'.. Done!，稍等片刻······就会出现所有带有afnetworking字段的类库。



