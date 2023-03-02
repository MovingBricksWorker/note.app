> [!ATTENTION] 参考包教不包会系列教程
> https://github.com/alsotang/node-lessons

```bash
mkdir nodeServer && cd nodeServer
npm install express --registry=https://registry.npmmirror.com
npm list
touch app.js
```

编辑`app.js`

```js
// 这句的意思就是引入 `express` 模块，并将它赋予 `express` 这个变量等待使用。
var express = require('express');
// 调用 express 实例，它是一个函数，不带参数调用时，会返回一个 express 实例，将这个变量赋予 app 变量。
var app = express();

// app 本身有很多方法，其中包括最常用的 get、post、put/patch、delete，在这里我们调用其中的 get 方法，为我们的 `/` 路径指定一个 handler 函数。
// 这个 handler 函数会接收 req 和 res 两个对象，他们分别是请求的 request 和 response。
// request 中包含了浏览器传来的各种信息，比如 query 啊，body 啊，headers 啊之类的，都可以通过 req 对象访问到。
// res 对象，我们一般不从里面取信息，而是通过它来定制我们向浏览器输出的信息，比如 header 信息，比如想要向浏览器输出的内容。这里我们调用了它的 #send 方法，向浏览器输出一个字符串。
app.get('/', function (req, res) {
  res.send('Hello World');
});

// 定义好我们 app 的行为之后，让它监听本地的 3001 端口。这里的第二个函数是个回调函数，会在 listen 动作成功后执行，我们这里执行了一个命令行输出操作，告诉我们监听动作已完成。
app.listen(3001, function () {
  console.log('http://localhost:3001 is starting');
});
```

执行 `node app.js` ,打开浏览器输入`http://localhost:3001`回车就可以看到页面上显示着`Hello World`,这就是一个简单的webserver应用,一般被用于做前端的mock数据接口

```js
/*引入express*/
const express = require('express');

var data = require('./mockData').data;

/*创建一个app实例*/
const app = express();

// 设置允许跨域访问该服务
app.all('*', function (req, res, next) {
  res.header('Access-Control-Allow-Origin', '*');
  res.header('Access-Control-Allow-Methods', 'PUT, GET, POST, DELETE, OPTIONS');
  res.header('Access-Control-Allow-Headers', 'X-Requested-With');
  res.header('Access-Control-Allow-Headers', 'Content-Type');
  res.header('Access-Control-Allow-Headers', 'mytoken');
  next();
});

/*配置路由
 访问 http://127.0.0.1:8081/user/userInfo 即可获取数据
 req和res可以自己处理 根据传参返回什么样的数据
*/
app.get('/user/userInfo', (req, res) => {
  res.send(data);
});


/*监听对象并收到错误回调*/
app.listen(8081, (err) => {
    if (!err){
        console.log('http://127.0.0.1:8081 已启动~ ');
    }
});
```