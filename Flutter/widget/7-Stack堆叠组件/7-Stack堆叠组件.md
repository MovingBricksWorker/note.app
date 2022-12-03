### Stack

```dart
import 'dart:ffi';
import 'package:flutter/material.dart';
 
void main() => runApp(TestApp());

class TestApp extends StatelessWidget {
  var stack = new Stack(
    alignment: const FractionalOffset(0.5,0.8),
    children: <Widget>[
      new CircleAvatar(
        backgroundImage: new NetworkImage('https://i0.hdslb.com/bfs/face/28dca5ff98f6c688b2b244ba5bf5f6208cf78ac2.jpg@150w_150h.jpg'),
        radius: 100.0
      ),
      Container(
        decoration: BoxDecoration(
          color: Colors.orangeAccent
        ),
        child: Text('CoderWGB工作室'),
        padding: const EdgeInsets.all(5.0)
      )
    ],
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "测试一下",
      theme: ThemeData(primaryColor: Colors.orangeAccent),
      home: Scaffold(
        appBar: AppBar(
          title: Text("真香警告⚠️"),
          // backgroundColor: Colors.cyanAccent,
        ),
        body: Center(
          child: stack
        ),
      ),
    );
  }
}

```



#### `Align`的使用

```dart
Container(
            color: Colors.red,
            width: 300.0,
            height: 300.0,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment(0, -1), //x,y的取值区间都是-1 ~ 1
                  child: Icon(Icons.open_with, color: Colors.blue),
                ),
                Align(
                  alignment: Alignment(0, 0), //x,y的取值区间都是-1 ~ 1
                  child: Icon(Icons.import_contacts, color: Colors.lightBlue),
                ),
                Align(
                  alignment: Alignment(1, 1), //x,y的取值区间都是-1 ~ 1
                  child: Icon(Icons.phone_iphone, color: Colors.blue),
                ),
                Align(
                  alignment: Alignment.topRight, //也提供枚举值
                  child: Icon(Icons.android, color: Colors.greenAccent),
                ),
              ],
            ),
          )
```



#### `Positioned`的使用

```dart
//一般超过三个子组件的时候使用 替代`alignment`的定位 
Stack(
    children: <Widget>[
      new CircleAvatar(
        // backgroundColor: Colors.orangeAccent,
        backgroundImage: new NetworkImage('https://i0.hdslb.com/bfs/face/28dca5ff98f6c688b2b244ba5bf5f6208cf78ac2.jpg@150w_150h.jpg'),
        radius: 100.0
      ),
      Positioned(
        top: 10.0,
        left: 10.0,
        child: Text('左上角'),
      ),
      Positioned(
        top: 10.0,
        right: 10.0,
        child: Text('右上角'),
      ),
      Positioned(
        bottom: 10.0,
        left: 10.0,
        child: Text('左下角'),
      ),
      Positioned(
        bottom: 10.0,
        right: 10.0, 
        child: Text('右下角'),
      ),
    ],
  )
```