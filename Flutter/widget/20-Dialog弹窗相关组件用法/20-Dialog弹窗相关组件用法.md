```dart
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DialogPage extends StatefulWidget {
  DialogPage({Key key}) : super(key: key);

  @override
  _DialogPageState createState() => _DialogPageState();
}

class _DialogPageState extends State<DialogPage> {
  _showDialog() async {
    var result = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.lightBlue[100],
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            title: Text("showDialog"),
            content: Text("这是一个弹窗,认真的弹窗!!!!"),
            actions: <Widget>[
              FlatButton(
                  textColor: Colors.white,
                  color: Colors.black,
                  child: Text("取消"),
                  onPressed: () {
                    Navigator.pop(context, "取消");
                  }),
              FlatButton(
                  textColor: Colors.white,
                  color: Colors.red,
                  child: Text("确定"),
                  onPressed: () {
                    Navigator.pop(context, "确定");
                  }),
            ],
          );
        });
    print("点击了$result");
  }

  _simpleDialog() async {
    var res = await showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text("选择一项吧"),
            children: <Widget>[
              SimpleDialogOption(
                child: Text("钱💰"),
                onPressed: () {
                  Navigator.pop(context, "钱💰");
                },
              ),
              Divider(),
              SimpleDialogOption(
                child: Text("美女👩"),
                onPressed: () {
                  Navigator.pop(context, "美女👩");
                },
              ),
              Divider(),
              SimpleDialogOption(
                child: Text("车🚘"),
                onPressed: () {
                  Navigator.pop(context, "车🚘");
                },
              ),
              Divider(),
              SimpleDialogOption(
                child: Text("房子🏡"),
                onPressed: () {
                  Navigator.pop(context, "房子🏡");
                },
              )
            ],
          );
        });
    print("选择了$res");
  }

  _bottomDialog() async {
    var selectIndex = await showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 250.0,
            child: Expanded(
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text("拍摄"),
                    onTap: () {
                      Navigator.pop(context, 1);
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.photo_album),
                    title: Text("从相册选"),
                    onTap: () {
                      Navigator.pop(context, 2);
                    },
                  ),
                  Divider(),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                    FlatButton(
                      color: Colors.white,
                      child: Text("取消"),
                      onPressed: () {
                        Navigator.pop(context, 0);
                      },
                    )
                  ])
                  // ListTile(
                  //   title: Text("取消"),
                  //   onTap: () {
                  //     Navigator.pop(context, 0);
                  //   },
                  // ),
                ],
              ),
            ),
          );
        });
    print('点击了${["取消", "拍摄", "从相册选"][selectIndex]}');
  }

  _toastAlert() {
    //第三方库
    Fluttertoast.showToast(
        msg: "这是一条提示消息这是一条提示消息这是一条提示消息这是一条提示消息这是一条提示消息",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 2,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dialog弹窗相关组件")),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text("showDialog"),
              onPressed: _showDialog,
            ),
            SizedBox(height: 20),
            RaisedButton(
              child: Text("simpleDialog"),
              onPressed: _simpleDialog,
            ),
            SizedBox(height: 20),
            RaisedButton(
              child: Text("bottomDialog"),
              onPressed: _bottomDialog,
            ),
            SizedBox(height: 20),
            RaisedButton(
              child: Text("Toast"),
              onPressed: _toastAlert,
            ),
          ],
        ),
      ),
    );
  }
}

```

#### 自定义Dialog

```dart
//自定义Dialog
class MyDialog extends Dialog {
  final String title;
  final String contentText;
  final String cancelTitle;
  final String confirmTitle;
  final TextStyle cancelTextStyle;
  final TextStyle confirmTextStyle;
  final Function(int) onClickButtonCallBack;
  final Function onCloseCallBack;

  MyDialog(
      {this.title = "温馨提示",
      this.contentText = "提示内容为空,请设置提示内容",
      this.cancelTitle = "取消",
      this.confirmTitle = "确认",
      this.cancelTextStyle,
      this.confirmTextStyle,
      this.onClickButtonCallBack,
      this.onCloseCallBack});

  @override
  Widget build(BuildContext context) {
    //调用定时器⏲
    // Timer.periodic(Duration(milliseconds: 3000), (t) {
    //   Navigator.pop(context); //3秒后自动关闭弹窗
    //   t.cancel(); //取消定时器
    // });

    return Material(
      type: MaterialType.transparency, //透明的蒙版
      child: Center(
          child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
        height: 280.0,
        width: 300.0,
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(10.0),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "${this.title}",
                        style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        child: Icon(Icons.close, size: 20.0, color: Colors.black54),
                        onTap: () {
                          Navigator.pop(context);
                          this.onCloseCallBack();
                        },
                      ),
                    ),
                  ],
                )),
            Divider(),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text("${this.contentText}", style: TextStyle(color: Colors.lightBlue, fontSize: 17.0)),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  color: Colors.black54,
                  child: Text(
                    this.cancelTitle,
                    style: this.cancelTextStyle ?? TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    this.onClickButtonCallBack(0);
                    this.onCloseCallBack();
                  },
                ),
                SizedBox(width: 30.0),
                FlatButton(
                  color: Colors.lightBlue,
                  child: Text(
                    this.confirmTitle,
                    style: this.confirmTextStyle ?? TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    this.onClickButtonCallBack(1);
                    this.onCloseCallBack();
                  },
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}

```