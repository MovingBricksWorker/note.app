```dart
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      title: "状态组件",
      home: Scaffold(appBar: AppBar(title: Text("状态组件")), body: FirstPage()),
    ));

class FirstPage extends StatefulWidget {
  FirstPage({Key key}) : super(key: key);
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  List list = new List();
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Column(
            children: this.list.map((value) {
          return ListTile(title: Text(value));
        }).toList()),
        SizedBox(height: 20),
        RaisedButton(
            child: Text("Add数据项"),
            onPressed: () {
              setState(() {
                var item = "这是数据项" + this.list.length.toString() ?? "0";
                this.list.add(item);
                // this.list.add("这是数据项2");
              });
            })
      ],
    );
  }
}
```

