### Row
```dart
//一般与容器组件结合使用
Row(
            children: <Widget>[
              //Expanded是撑开布局的一层包装
              Expanded(child:Icon(Icons.headset,color: Colors.greenAccent)),
              Expanded(child:Text("酷狗🎵",style: TextStyle(backgroundColor: Colors.lightBlue))),
              Expanded(child:Text("我爱❤️我家",style: TextStyle(backgroundColor: Colors.deepOrange)))
            ],
            mainAxisSize: MainAxisSize.min, //主轴的size
            crossAxisAlignment: CrossAxisAlignment.center,//交叉轴对齐方式
            mainAxisAlignment: MainAxisAlignment.center,//主轴轴对齐方式
          )
```


### Column

```dart
//使用方法与Row类似
Column(
            children: <Widget>[
              Text("我爱❤️我家",style: TextStyle(backgroundColor: Colors.deepOrange)),
              Expanded(child:Icon(Icons.headset,color: Colors.greenAccent)),
              Text("酷狗🎵",style: TextStyle(backgroundColor: Colors.lightBlue))
            ],
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
          )
```


