#### 方法一

```dart
import 'package:flutter/material.dart';
import '../home/home.dart';
import '../category/category.dart';
import '../find/find.dart';
import '../settings/settings.dart';

class TabBarPage extends StatefulWidget {
  TabBarPage({Key key}) : super(key: key);
  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> {
  //默认选中第一个
  int _currentIndex = 0;
  //标题
  final List<String> titles = [
    "微信",
    "通讯录",
    "发现",
    "我",
  ];
  //图标
  final List<Icon> icons = [Icon(Icons.chat_bubble), Icon(Icons.contact_mail), Icon(Icons.search), Icon(Icons.person)];

  // 各模块页面 都是继承自状态组件
  final List<Widget> pages = [HomePage(), CategoryPage(), FindPage(), SettingsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(this.titles[this._currentIndex])),
      body: pages[this._currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: this._currentIndex,
          onTap: (int index) {
            setState(() {
              this._currentIndex = index;
            });
          },
          unselectedItemColor: Colors.grey,
          fixedColor: Colors.red, //选中颜色
          iconSize: 30.0, //icon大小
          type: BottomNavigationBarType.fixed, //大于等于4个item需要设置该属性
          items: List.generate(
              titles.length, (index) => BottomNavigationBarItem(icon: icons[index], title: Text(titles[index])))),
    );
  }
}

```

#### 方法二 
[参考demo代码](https://github.com/WangGuibin/FlutterStudyDailyCase/tree/master/tabbar/flutter_scaffold)
```dart
import 'package:flutter/material.dart';
import 'package:flutter_scaffold/provide/current_index_provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import './home.dart';
import './category.dart';
import './cart.dart';
import './search.dart';
import './me.dart';

class TabBarPage extends StatelessWidget {
  //底部按钮
  final List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(title: Text("首页"), icon: Icon(Icons.home)),
    BottomNavigationBarItem(title: Text("分类"), icon: Icon(Icons.category)),
    BottomNavigationBarItem(title: Text("购物车"), icon: Icon(Icons.shopping_cart)),
    BottomNavigationBarItem(title: Text("搜索"), icon: Icon(Icons.search)),
    BottomNavigationBarItem(title: Text("我的"), icon: Icon(Icons.person)),
  ];

  final List<Widget> bodyWidgets = [HomePage(), CategoryPage(), CartPage(), SearchPage(), MePage()];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
    return Provide<CurrentIndexProvide>(
      builder: (context, child, val) {
        int currentIndex = Provide.value<CurrentIndexProvide>(context).currentIndex;
        return Scaffold(
          backgroundColor: Colors.red,
          bottomNavigationBar: BottomNavigationBar(
            fixedColor: Colors.pink,
            unselectedItemColor: Colors.blue,
            items: bottomItems,
            currentIndex: currentIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              Provide.value<CurrentIndexProvide>(context).setSelectIndex(index);
            },
          ),
          body: IndexedStack(children: bodyWidgets, index: currentIndex),
        );
      },
    );
  }
}

```
