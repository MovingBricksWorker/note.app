由于某些后端大佬日理万机,而接口经常处于难产的情况~ 数据结构之类的已经确定好了,剩下的就是联调的一个过程
为了模拟网络请求的真实性,所以采用本地webServer的形式进行mock提交网络请求~ ,这里采用的是最简单的python实现

## GET请求
这个因为解析库是python2.x的 所以目前get仅支持python2.x  后续可升级

> http://172.20.10.2:8080/?name=CoderWGB&no=666666

```python
# coding:utf-8
import json
from urlparse import parse_qs
from wsgiref.simple_server import make_server
 
# 定义函数，参数是函数的两个参数，都是python本身定义的，默认就行了。
def application(environ, start_response):
# 定义文件请求的类型和当前请求成功的code
    start_response('200 OK', [('Content-Type', 'text/html')])
# environ是当前请求的所有数据，包括Header和URL，body，这里只涉及到get
# 获取当前get请求的所有数据，返回是string类型 解析URL带的参数
    params = parse_qs(environ['QUERY_STRING'])
    # 获取get中key为name的值
    name = params.get('name', [''])[0]
    no = params.get('no', [''])[0]
    # 组成一个数组，数组中只有一个字典
    dic = {'name': name, 'no': no}
    #返回回调数据
    return [json.dumps(dic)]
if __name__ == "__main__":
    port = 8080
    httpd = make_server("0.0.0.0", port, application)
    print("serving http on port {0}...".format(str(port)))
    httpd.serve_forever()
``` 

## POST请求
支持python2.x和python3.x

```python
# coding:utf-8

import json 
from wsgiref.simple_server import make_server
 
# 定义函数，参数是函数的两个参数，都是python本身定义的，默认就行了。
def application(environ, start_response):
    # 定义文件请求的类型和当前请求成功的code
    start_response('200 OK', [('Content-Type', 'application/json')])
    # environ是当前请求的所有数据，包括Header和URL，body

    request_body = environ["wsgi.input"].read(int(environ.get("CONTENT_LENGTH", 0))) 
    request_body = json.loads(request_body)
    
    # 这里拿到body的参数进行CRUD
    # name = request_body["name"] 
    # no = request_body["no"]

    # 回调组装数据 
    # dic = {'name': name, 'no': no}
    # return [json.dumps(dic)]
    # 原路返回 body数据 
    return [json.dumps(request_body)]
 
if __name__ == "__main__":
    port = 8080
    httpd = make_server("0.0.0.0", port, application)
    print("serving http on port {0}...".format(str(port)))
    httpd.serve_forever()
```