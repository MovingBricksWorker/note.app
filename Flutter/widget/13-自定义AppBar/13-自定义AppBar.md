```dart
//隐藏Debug标识
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      onGenerateRoute: onGenerateRoute,
      debugShowCheckedModeBanner: false, //隐藏Debug标识
    );
  }
}

//自定义AppBar
AppBar(
        title: Text("自定义AppBar"),
        centerTitle: true, //标题组件居中
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              print("菜单");
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              print("搜索");
            },
          ),
        ],
        // bottom: ,//该属性一般放tabBar组件
      )

 
```

