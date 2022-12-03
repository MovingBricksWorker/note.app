## Flutter自定义Tabbar底部tab菜单导航

```dart
import 'package:flutter/material.dart';
import './home.dart';
import './category.dart';
import './cart.dart';
import './search.dart';
import './me.dart';

class TabBarPage extends StatefulWidget {
  const TabBarPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _TabBarPageState();
  }
}

class _TabBarPageState extends State<TabBarPage> {
  //底部按钮
  final List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(label: "首页", icon: Icon(Icons.home)),
    const BottomNavigationBarItem(label: "分类", icon: Icon(Icons.category)),
    const BottomNavigationBarItem(
        label: "购物车", icon: Icon(Icons.shopping_cart)),
    const BottomNavigationBarItem(label: "搜索", icon: Icon(Icons.search)),
    const BottomNavigationBarItem(label: "我的", icon: Icon(Icons.person)),
  ];
  final List<Widget> bodyWidgets = [
    const HomePage(),
    const CategoryPage(),
    const CartPage(),
    const SearchPage(),
    const MePage()
  ];

  int selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.pink,
        unselectedItemColor: Colors.blue,
        items: bottomItems,
        currentIndex: selectIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            selectIndex = index;
          });
        },
      ),
      body: IndexedStack(index: selectIndex, children: bodyWidgets),
    );
  }
}

```