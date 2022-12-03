# 开发中遇到的问题总结汇总

## Running Gradle task 'assembleDebug'...
>需要修改安卓项目里的依赖Gradle文件, Gradle的Maven仓库在国外, 需要使用阿里云的镜像地址替换一下
> android/build.gradle 和 packages/flutter_tools/gradle/flutter.gradle都需要改一下
```maven
// google()
// jcenter()

// 添加国内的镜像
maven { url 'https://maven.aliyun.com/repository/google' }
maven { url 'https://maven.aliyun.com/repository/jcenter' }
maven { url 'http://maven.aliyun.com/nexus/content/groups/public' }
```

##  有`FloatingActionButton `的页面,跳转二级页面会出现黑屏的现象

> There are multiple heroes that share the same tag within a subtree.

**Flutter首页里加了脚手架里的加号按钮`floatingActionButton`,页面结构大致是这样,从上往下依次是appBar,ListView,floatActionButton..,在listView的item里面的一个点击回调的事件里做页面跳转,一跳转就是黑屏,这个问题折腾了许久,主要花在了排查问题上,排查了路由设置问题和类名以及页面结构等问题之后还是无果,最后拿控制台的一句话"There are multiple heroes that share the same tag within a subtree."粘贴到google上出来了一些结果,问题根源在于FloatingActionButton的一个属性标识即`heroTag`没有设置,要手动设置一个标识唯一即可**

```dart

Provide<MyCounter>(
      builder: (context, child, val) {
        int currentCount = Provide.value<MyCounter>(context).currentCount;
        return Scaffold(
          appBar: AppBar(
            title: Text("首页 $currentCount", style: TextStyle(color: Colors.white)),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.blue[100], Colors.blue[300], Colors.blue],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
              ),
            ),
          ),
          body: Container(
              child: ListView.builder(
            itemCount: dataList.length,
            itemBuilder: (BuildContext context, int index) {
              String name = dataList[index].name;
              Function callBack = dataList[index].tapCallBack;
              return Column(
                children: <Widget>[
                  ListTile(
                    title: Text(name),
                    onTap: callBack,
                  ),
                  Divider(),
                ],
              );
            },
          )),
          floatingActionButton: FloatingActionButton(
            heroTag: "你大爷的", //就是这个玩意儿
            child: Icon(Icons.add, color: Colors.white, size: 44),
            backgroundColor: Colors.blueAccent,
            onPressed: () {
              Provide.value<MyCounter>(context).updateCount(currentCount);
            },
          ),
        );
      },
    );

```
**参考博文**
[Flutter： There are multiple heroes that share the same tag within a subtree异常](https://blog.csdn.net/sjdjdjdjahd/article/details/100137172)
[flutter 跳转报错：There are multiple heroes that share the same tag within a subtree.](https://www.jianshu.com/p/5599c3be7a38)


##  终端设置代理导致热重载失败或者是用不了
**解决办法:**
**在终端的`~/.zshrc`或者`~/.bash_profile`中查找如下设置代理的代码,暂时先注释掉,souce更新一下再看看是啥情况**
```shell
export http_proxy=http://代理ip:端口
export https_proxy=http://代理ip:端口
```
重启`VSCode`和终端,再次`flutter run`,惊喜出现了:
```shell
.... 
Flutter run key commands.
r Hot reload. 🔥🔥🔥
R Hot restart.
h Repeat this help message.
d Detach (terminate "flutter run" but leave application running).
c Clear the screen
q Quit (terminate the application on the device).
An Observatory debugger and profiler on iPhone 11 Pro Max is available at: http://127.0.0.1:52116/sXVB7ndU73U=/
```

## Waiting for another flutter command to release the startup lock...

```shell
rm ./flutter/bin/cache/lockfile
```


##  旧项目编译失败
```
  Error: Could not resolve the package 'characters' in 'package:characters/characters.dart'.
    ../../../../flutter/packages/flutter/lib/src/material/text_field.dart:9:8: Error: Not found: 'package:characters/characters.dart'
    import 'package:characters/characters.dart';
           ^
    ../../../../flutter/packages/flutter/lib/widgets.dart:18:1: Error: Not found: 'package:characters/characters.dart'
    export 'package:characters/characters.dart';
    ^
```
>  flutter pub cache repair 或者 flutter clean 然后 flutter run