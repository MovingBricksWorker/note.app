# Flutter与iOS之间平台通信(platform channel)基本流程

##  创建插件项目

```shell
# 命令解读 
# -i 指的是iOS平台选择什么语言 后接语言类型 objc/swift
# -a 指的是Android平台 后接语言类型 java/kotlin
flutter create --template=plugin -i objc -a java MyPlugin
cd  MyPlugin/example
flutter run #试试项目能否跑🏃起来
```

*等待命令执行完即可*

目录结构大致如下:

```shell
.
├── CHANGELOG.md
├── LICENSE
├── MyPlugin.iml
├── README.md
├── android   #安卓平台代码
├── example #demo例子🌰
├── ios   #iOS平台代码
├── lib   #插件通信代码 
├── pubspec.lock 
├── pubspec.yaml
└── test
```



## 开始编写插件代码

**首先打开项目找到`MyPlugin.dart`文件**

```dart
import 'dart:async';

import 'package:flutter/services.dart';

class MyPlugin {
  static const MethodChannel _channel = const MethodChannel('MyPlugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

//新增一个方法 用于发送字典即Map参数给iOS平台 返回值是泛型类型用于接收iOS发送过来的消息内容
  static Future<dynamic> dartSendMessageToIOS(Map<String, dynamic> args) {
    return _channel.invokeMethod("dartSendMessageToIOS", args);
  }
}

```



**其次找到`example/main.dart`用于开发调试插件代码**

```dart
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:MyPlugin/MyPlugin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
    initDartSendMessage();
  }

  Future<void> initDartSendMessage() async {
    dynamic args; //定义接收对应平台的返回值 (这里指iOS平台,Android端暂未实现)
    try {
      args = await MyPlugin.dartSendMessageToIOS({
        "floatNumber": 0.02,
        "number": 666,
        "str": "字符串",
        "arr": ["item1", "item2", "item3"],
        "dict": {"key": "value"}
      });
      print("iOS获取过来的数据如下:\n $args");
    } on PlatformException catch(e) {
        print("出错了:\n $e");
    }
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await MyPlugin.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}

```

关于通道(channel)的数据类型交互可参考[flutter中文网的介绍](https://flutterchina.club/platform-channels/#codec)

**最后就是使用Xcode打开`example/ios/Runner.xcodeproj`编辑本地库里的插件文件`MyPlugin.m`**

```objectivec
#import "MyPlugin.h"

@implementation MyPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"MyPlugin"
            binaryMessenger:[registrar messenger]];
  MyPlugin* instance = [[MyPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  }else if ([@"dartSendMessageToIOS" isEqualToString:call.method]){
      //dart 发送一些参数给iOS,收到消息之后做一些事情
      
      //dart传的参数字典也就是Map
      NSDictionary *args = call.arguments;
      NSLog(@"dart发送过来的数据:");
      NSLog(@"floatNumber: %@",args[@"floatNumber"]);
      NSLog(@"str: %@",args[@"str"]);
      NSLog(@"arr: %@",args[@"arr"]);
      NSLog(@"dict: %@",args[@"dict"]);
      NSLog(@"dict[key]: %@",args[@"dict"][@"key"]);

      //给flutter channel发送一些参数过去 dart收到会打印显示的
      result(@{
          @"float" : @(0.0666),
          @"int" : @(1111),
          @"strings" : @"哈哈哈哈,我是字符串了",
          @"array" : @[@"iOS",@"Swift",@"Flutter"],
          @"dict" : @{@"iOS":@"666"}
      });
      
  }else {
    result(FlutterMethodNotImplemented);
  }
}

@end

```



## 最后,运行代码查看效果

```shell
cd example
flutter run
```

**附上一张控制台打印的效果图**

![](https://images.cnblogs.com/cnblogs_com/wgb1234/1662566/o_2004021205531.png)


[配合鹅厂大佬的DartNative插件使用那是真的香~](http://yulingtianxia.com/blog/2020/06/25/Codegen-for-DartNative)