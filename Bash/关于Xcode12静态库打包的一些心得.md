# 关于Xcode12静态库打包的一些心得
* [编译.a的脚本如下(采用手动编译 脚本合成):](#编译a的脚本如下采用手动编译脚本合成)
* [编译framework与.a类似](#编译framework与a类似)
* [更新于2020-01-11](#更新于2020-01-11)
* [-all_load , -force_load , -ObjC 的区别和妙用](#-all_load---force_load---objc-的区别和妙用)
* [一些相关文章](#一些相关文章)

> 最近在玩静态库打包,时不时遇到如下这种报错,可能是Xcode升级的缘故,之前是没有遇到过,故此总结了一波...
 
 `Building for iOS Simulator, but the linked library 'libxxx.a' was built for iOS.`

 这个问题是因为模拟器编译的那个`.a`没有合并,只是打了真机的`.a`,运行到模拟器而模拟器是`x86_64`的架构,如果不需要模拟器调试,直接真机的即可

另: 模拟器打包与真机的包无法合并,出现arm64重复,无法合并为fat的问题
 `Build settings->Excluded Architectures`里忽略当前`SDK`不支持的架构
 模拟器SDK下可以忽略真机的架构`arm64`,`arm64e`,其实不适配5s以下的话直接把i386也去掉也是可以的,同样真机也可去掉armv7和armv7s,这样做的好处是可以减小包体积

现在新iPhone X以上iPhone 11 iPhone12等支持新架构得加一个`arm64e`,在`Architectures`里的`other`里手动添加即可


 所以目前解决办法就是打多个版本的静态库 
 比如:  
 - 全量包 i386,x86_64,armv7,armv7s,arm64,arm64e 
 - 拆分包
 	- 真机和模拟器的拆分
 		- 模拟器 i386,x86_64
 		- 真机 armv7,armv7s,arm64,arm64e 
 	- 每一种架构单独拎出来,lipo命令自己按需合并 

一般来说,开发调试的话就用全量包,发布上线用真机包

**讲道理,一些旧设备都被系统所淘汰了,iOS10起步支持iPhone 5s以上,那就大可不必支持i386和armv7,直接arm64和x86_64即可,上线打包可以剔除x86_64,这样才是最优解**

## 编译.a的脚本如下(采用手动编译+脚本合成):
 ps: 自动编译在Xcode12.3不知道出了什么鬼,xcodebuild一直死循环就是编译不过,无奈之下采取半自动了,不过配合say语音提示也是可以的
```bash
#! /bin/sh
# 先在工程根目录创建好SDK文件夹
mkdir -p ${PROJECT_NAME}_SDK
cd ${PROJECT_NAME}_SDK
mkdir -p ${PROJECT_NAME}
cd ${PROJECT_NAME}
mkdir -p include
mkdir -p lib

#回到工程目录
cd ./../../
#真机build生成的.a文件路径
DEVICE_DIR_A=${BUILD_DIR}/${CONFIGURATION}-iphoneos/lib${PROJECT_NAME}.a
#模拟器build生成的.a文件路径
SIMULATOR_DIR_A=${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/lib${PROJECT_NAME}.a

if [[ -f "${DEVICE_DIR_A}" ]]; then
	say "真机编译完成"
fi

if [[ -f "${SIMULATOR_DIR_A}" ]]; then
	say "模拟器编译完成"
fi

if [[ -f "${DEVICE_DIR_A}" ]] ; then
	if [[ -f "${SIMULATOR_DIR_A}" ]]; then
		lipo -create ${DEVICE_DIR_A} ${SIMULATOR_DIR_A} -output ./${PROJECT_NAME}_SDK/${PROJECT_NAME}/lib/lib${PROJECT_NAME}.a
		#头文件转移大法
		HEADER_FOLDER="${BUILD_DIR}/${CONFIGURATION}-iphoneos/include/${PROJECT_NAME}"
		cp -a ${HEADER_FOLDER}/. ./${PROJECT_NAME}_SDK/${PROJECT_NAME}/include
		open ./
		say "静态库合并成功"
	fi
fi

```

<video 
controls
width="720" 
height="480"
    loop
    preload="auto"
   webkit-playsinline="true"
    playsinline="true"
    x5-video-player-type="h5"
    x5-video-player-fullscreen="true"
    x-webkit-airplay="allow" 
    x5-video-orientation="portraint"
    style="object-fit:fill">
        <source src="https://cdn.jsdelivr.net/gh/WangGuibin/MyFilesRepo/images/1610240744.mp4" type="video/mp4">
</video>

## 编译framework与.a类似
```bash
#! /bin/sh
#创建存放目录
mkdir -p ${PROJECT_NAME}.framework
INSTALL_DIR=./${PROJECT_NAME}.framework

#真机编译产物
DEVICE_DIR=${BUILD_DIR}/${CONFIGURATION}-iphoneos/${PROJECT_NAME}.framework
#模拟器编译产物
SIMULATOR_DIR=${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${PROJECT_NAME}.framework

#.framework是目录是文件夹 所以用-d判断 文件用-f
if [[ -d "$DEVICE_DIR" ]]; then
	say "真机编译完成"
fi

if [[ -d "$SIMULATOR_DIR" ]]; then
	say "模拟器编译完成"
fi

if [[ -d "${DEVICE_DIR}" ]] ; then
	if [[ -d "${SIMULATOR_DIR}" ]]; then
		cp -R ${DEVICE_DIR}/ ${INSTALL_DIR}/
		lipo -create "${DEVICE_DIR}/${PROJECT_NAME}" "${SIMULATOR_DIR}/${PROJECT_NAME}" -output "${INSTALL_DIR}/${PROJECT_NAME}"
		open ./
		say "静态库合并成功"
	fi
fi
```

<video 
width="720" 
height="480"
controls
    loop
    preload="auto"
   webkit-playsinline="true"
    playsinline="true"
    x5-video-player-type="h5"
    x5-video-player-fullscreen="true"
    x-webkit-airplay="allow" 
    x5-video-orientation="portraint"
    style="object-fit:fill">
        <source src="https://cdn.jsdelivr.net/gh/WangGuibin/MyFilesRepo/images/1610240648.mp4" type="video/mp4">
</video>


##  更新于2020-01-11
有时候模拟器编译失败而报错
`The linked library 'xxxx.a/Framework' is missing one or more architectures required by this target: armv7/或者是x86_64`
真机SDK编译模拟器或者是模拟器SDK编译真机,`lipo -info xxx`查看架构排除原因
① 如果是没有合并,则需要合并
② 如果已合并,则需要差异化排除

在TARGETS ——> Build Settings-Excluded Architectures 添加如下代码:
```objc
EXCLUDED_ARCHS__EFFECTIVE_PLATFORM_SUFFIX_simulator__NATIVE_ARCH_64_BIT_x86_64=arm64 arm64e armv7 armv7s armv6 armv8 EXCLUDED_ARCHS=$(inherited) $(EXCLUDED_ARCHS__EFFECTIVE_PLATFORM_SUFFIX_$(EFFECTIVE_PLATFORM_SUFFIX)__NATIVE_ARCH_64_BIT_$(NATIVE_ARCH_64_BIT))
```
选择模拟器SDK编译的时候,排除真机架构,同理,编译真机SDK时,排除模拟器的架构,`Excluded`是排除的意思. 拷贝上面这句代码往上一粘就完事了


## -all_load , -force_load , -ObjC 的区别和妙用

1. `-all_load` 链接器把目标文件都加载进来,不能草率使用这个,项目很大或者依赖的库很多可能会出现冲突,提示重复依赖之类的错误,在知道各个库使用情况之下,最好是使用`-force_load`一个个指定库文件去加载. 
2. `-force_load` 与`-all_load`用法类似,指定目标文件加载
3. `-ObjC`用于加载分类category,类和分类同时存在于静态库时使用`-ObjC`没毛病,但是如果没有包含类对象,仅仅只是category是加载不进去的,如果什么都不加,静态库中的category在外部调用的时候会直接报错: unrecognized selector xxx , 一般情况都是配合 `-all_load` 和 `-force_load`一起使用. 


## 一些相关文章
* [解决-Xcode-11-4-以来模拟器编译报错-Building-for-iOS-Simulator-but-the-linked-library-was-built-for-iOS-的正确姿势](https://blog.lessney.com/blog/2020/05/22/解决-Xcode-11-4-以来模拟器编译报错-Building-for-iOS-Simulator-but-the-linked-library-was-built-for-iOS-的正确姿势/)
* [Xcode 12 - Architecture相关问题](https://www.jianshu.com/p/5f896321b1ea)
* [iOS CPU架构(ARM指令集)](https://www.jianshu.com/p/461edde66d02)
* [iOS 打包移除 i386 和 x86_64 平台动态库](https://juejin.cn/post/6844903859731578887)
* [Python小工具: 去除iOS静态库(.a或.framework)模拟器架构代码](https://www.cnblogs.com/YueHeiZS/p/9252186.html)
* [Xcode升级12编译报错The linked library is missing one or more architectures required by this target](https://my.oschina.net/jack088/blog/4882667)