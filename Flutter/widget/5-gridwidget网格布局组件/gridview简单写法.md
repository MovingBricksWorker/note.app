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
        body: GridView.count(
          padding: const EdgeInsets.all(10.0),
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 20.0,
          crossAxisCount: 3,
          children: <Widget>[
            const Text("哈哈哈哈哈哈"),
            const Text("哈哈哈哈哈哈"),
            const Text("哈哈哈哈哈哈"),
            const Text("哈哈哈哈哈哈"),
            const Text("哈哈哈哈哈哈"),
            const Text("哈哈哈哈哈哈"),
          ],
        ),
      ),
    );
  }
}

```