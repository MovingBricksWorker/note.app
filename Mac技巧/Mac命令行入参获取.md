##  OC

> 参考该项目  https://github.com/WangGuibin/lz-string-objc 的MacOS示例代码即可
<br/>
1. 新建 MacApp
2. 修改main.m ,不需要运行循环便直接return 0 了事

  测试代码如下: 

```objc
int main(int argc, const char * argv[]) {
    //MacApp的编译产物中找到可执行文件 Mac.app/Contents/MacOS/MacApp -o "hello world"
    NSString *arg = [[NSUserDefaults standardUserDefaults] stringForKey:@"o"];
    NSLog(@"OC打印: %@",arg);
    printf("C打印: %s\n",[arg UTF8String]);
    return 0;
}
```

然后直接 <kbd> ⌘</kbd> + <kbd>B</kbd> 编译一下,然后找到编译产物目录下的可执行文件(一般在`~/Library/Developer/Xcode/DerivedData`该路径下找快一些)

![](https://cdn.jsdelivr.net/gh/WangGuibin/ImageBed@master/Xnip2021-12-31_20-01-15.png)





## C/C++

1. 创建一个命令行项目即可
2. 代码如下:

```c++
#include <iostream>

using namespace std;

int main(int argc, const char * argv[]) {
    // gcc main.cpp -lstdc++ -o  helloworld   #编译
    //./helloworld "hhh" "ggg" "123" "jk666"  #调用
    cout << argv[0] << endl;// ./helloworld
    cout << argv[1] << endl;// hhh
    cout << argv[2] << endl;// ggg
    cout << argv[3] << endl;// 123
    cout << argv[4] << endl;// jk666
        
    return 0;
}

```
还有这个类的属性也可以获取到
[NSProcessInfo procrsss].argmuents