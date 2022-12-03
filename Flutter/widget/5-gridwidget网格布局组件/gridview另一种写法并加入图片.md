```dart
import 'package:flutter/material.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,//一行几个
            mainAxisSpacing: 2.0,//主轴间隙
            crossAxisSpacing: 2.0,//交叉轴间隙
            childAspectRatio: 0.75 //宽高比例 
          ),
          children: <Widget>[
            new Image.network("http://img5.mtime.cn/mg/2019/12/06/151725.72056401_170X256X4.jpg",fit: BoxFit.cover),
            new Image.network("http://img5.mtime.cn/mg/2019/12/27/102157.68986647_170X256X4.jpg",fit: BoxFit.cover),
            new Image.network("http://img5.mtime.cn/mg/2019/12/17/105244.25525559_170X256X4.jpg",fit: BoxFit.cover),
            new Image.network("http://img5.mtime.cn/mg/2019/12/27/101620.49593666_170X256X4.jpg",fit: BoxFit.cover),
            new Image.network("http://img5.mtime.cn/mg/2019/12/16/102340.68068947_170X256X4.jpg",fit: BoxFit.cover),
            new Image.network("http://img5.mtime.cn/mg/2020/01/16/151219.82587599_170X256X4.jpg",fit: BoxFit.cover),
            new Image.network("http://img5.mtime.cn/mg/2019/12/16/160312.57013739_170X256X4.jpg",fit: BoxFit.cover),
            new Image.network("http://img5.mtime.cn/mg/2019/12/09/170926.23949705_170X256X4.jpg",fit: BoxFit.cover),
            new Image.network("http://img5.mtime.cn/mg/2019/12/27/101324.51348949_170X256X4.jpg",fit: BoxFit.cover),
            new Image.network("http://img5.mtime.cn/mg/2019/12/06/151725.72056401_170X256X4.jpg",fit: BoxFit.cover),
            new Image.network("http://img5.mtime.cn/mg/2019/12/27/102157.68986647_170X256X4.jpg",fit: BoxFit.cover),
            new Image.network("http://img5.mtime.cn/mg/2019/12/17/105244.25525559_170X256X4.jpg",fit: BoxFit.cover),
            new Image.network("http://img5.mtime.cn/mg/2019/12/27/101620.49593666_170X256X4.jpg",fit: BoxFit.cover),
            new Image.network("http://img5.mtime.cn/mg/2019/12/16/102340.68068947_170X256X4.jpg",fit: BoxFit.cover),
            new Image.network("http://img5.mtime.cn/mg/2020/01/16/151219.82587599_170X256X4.jpg",fit: BoxFit.cover),
            new Image.network("http://img5.mtime.cn/mg/2019/12/16/160312.57013739_170X256X4.jpg",fit: BoxFit.cover),
            new Image.network("http://img5.mtime.cn/mg/2019/12/09/170926.23949705_170X256X4.jpg",fit: BoxFit.cover),
            new Image.network("http://img5.mtime.cn/mg/2019/12/27/101324.51348949_170X256X4.jpg",fit: BoxFit.cover)

          ],
        ),
      ),
    );
  }
}
```