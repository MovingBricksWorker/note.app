```dart
Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text("中国加油!武汉加油💪!",style: TextStyle(fontWeight: FontWeight.w500)),
            subtitle: Text("电话: 0797-28780XX"),
            leading: Icon(Icons.phone_android),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
          Divider(),
          ListTile(
            title: Text("中国加油!武汉加油💪!",style: TextStyle(fontWeight: FontWeight.w500)),
            subtitle: Text("手机号: 13058086666"),
            leading: Icon(Icons.phone),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
          Divider(),
          ListTile(
            title: Text("中国加油!武汉加油💪!",style: TextStyle(fontWeight: FontWeight.w500)),
            subtitle: Text("email: 0x00@163.com"),
            leading: Icon(Icons.email),
            trailing: Icon(Icons.keyboard_arrow_right),
          )
        ],
      ),
    )
```