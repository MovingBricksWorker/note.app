
## Flutter路由的配置

`main.dart`
```dart
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: KSting.appTitle,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      initialRoute: '/',
      onGenerateRoute: onGenerateRoute,
    );
  }
}

```

`initialRoute `初始入口路由,一般默认为首页的路由
`onGenerateRoute`函数的固定写法,一般写在定义路由的一个公共的地方
```dart
final Map<String, Function> routes = {
  '/': (context, {arguments}) => TabBarPageVC(),
  '/home': (context, {arguments}) => HomePage(),
  '/goods': (context, {arguments}) => GoodsPage(),
  '/detail': (context, {arguments}) => DetailPage(arguments: arguments),
  '/search': (context, {arguments}) => SearchPage(arguments: arguments),
  '/customAppBar': (context, {arguments}) => CustomAppBarPage(),
  '/toutiaoTab': (context, {arguments}) => TouTiaoTabPage(),
  '/categoryTab': (context, {arguments}) => CategoryPage(),
  '/tabBarVCDemo': (context, {arguments}) => TabBarControllerPage(),
  '/user': (context, {arguments}) => UserPage(),
  '/buttons': (context, {arguments}) => ButtonWidgetPage(),
  '/textfield': (context, {arguments}) => TextfieldPage(),
  '/checkbox': (context, {arguments}) => CheckBoxPage(),
  '/datePicker': (context, {arguments}) => DatePickerPage(),
  '/banner': (context, {arguments}) => BannerPage(),
  '/dialog': (context, {arguments}) => DialogPage(),
  '/request': (context, {arguments}) => HttpRequestPage(),
};

//命名路由传参的固定写法
var onGenerateRoute = (RouteSettings settings) {
  // 统一处理
  final String? name = settings.name;
  final Function? pageContentBuilder = routes[name];

  if (pageContentBuilder != null) {
    final Route route = MaterialPageRoute(
        builder: (context) =>
            pageContentBuilder(context, arguments: settings.arguments));
    return route;
  }
  return null;
};

```

调用路由
```dart
Navigator.of(context).pushNamed("/detail", arguments: {'id': 'home -> detail'});
```
如果页面需要传参,构造函数也要加一个argments
```dart
 class DetailPage extends StatelessWidget {
  var arguments;
  DetailPage({Key key, this.arguments}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("详情页"),
        ),
        body: Center(
          child: RaisedButton(
            child: Text("接收参数: ${this.arguments != null ? this.arguments['id'] : '0'} \n 点击返回根路由"),
            onPressed: () {
              //返回根路由
              Navigator.of(context).pushAndRemoveUntil(
                  new MaterialPageRoute(builder: (context) => new TabBarPageVC()), (route) => route == null);
            },
          ),
        ));
  }
}
```
push路由替换页面的两种方式
```dart
//替换路由的两种方式:
 Navigator.of(context).pushReplacementNamed("/detail",
                arguments: {"id": "replace替换路由切换页面 goods -> detail,goods销毁,detail代替该层级"});
 Navigator.pushReplacementNamed(context, '/detail',
                arguments: {"id": "replace替换路由切换页面 goods -> detail,goods销毁,detail代替该层级"});
```