# 面试总结

1. 关于`self`和`super`的理解,子类实例化时打印`NSStringFromClass([super class])`结果是什么?

```objectivec
@interface Animational : NSObject
@end
@implementation Animational
@end

@interface Dog : Animational
@end

@implementation Dog

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"%@",NSStringFromClass([self class])); //打印Dog
        NSLog(@"%@",NSStringFromClass([super class]));//打印Dog
        
        /**
        本质都是消息转发,区别在于内部调用
         self调用的是objc_msgSend 从当前类方法列表中查找,打印当前类的类名
         
         
         super调用的是objc_msgSendSuper 从父类方法列表中查找  
         objc_msgSendSuper(struct objc_super * _Nonnull super, SEL _Nonnull op, ...)
         struct objc_super {
             __unsafe_unretained _Nonnull id receiver; //这个是self
             __unsafe_unretained _Nonnull Class super_class;
         };
         即
         struct objc_super dog_super = {
             self,
             class_getSuperclass([self class])
         };
         id res = objc_msgSendSuper(&dog_super, @selector(class));
         NSLog(@"===objc_msgSendSuper===%@===", res);
         打印结果是Dog
       
         */

    }
    return self;
}

@end


```

2. `UIScrollView`滚动时影响了`NSTimer`的运行.为什么? 如何改进优化?

```objectivec
因为UIScrollView手势交互的NSRunLoop的优先级比定时器的高,需要设置NSRunloopCommonModes提高NSTimer的优先级即可不受手势滑动影响
```

3. `KVC`取数组的平均值如何操作

```objectivec
double value = [employes valueForKeyPath:@"@avg.doubleValue"]  //employes数组里应该是都是NSNumber类型才可以使用
```

4. 这些项目中有没有遇到过棘手问题,你是如何解决的

   ```objectivec
   Mpush方案实施遇到的困难,后来联系开源开发者了解设计初衷以及要了一些解决问题的思路 => 具体事例
   一般问题上google或者Stack Overflow   => 思路
   github提issue 论坛发帖提问 微信群问大佬求助  => 人脉/资源
   ```

5. 关于Socket长链断线重连,断网处理以及丢包处理

6. 聊天列表很多高清大图,如何优化滚动卡顿问题以及内存泄漏

   ```objectivec
   采用异步加载,后台线程监听Runloop,限制加载任务数,一旦超出阈值就移除旧的任务
   ```

7. 谈谈你对MVC和MVVM的理解

```objectivec
MVC 根据自己的理解巴拉巴拉
MVVM 各有各的理解 解耦才是关键
```

4. 你认为你目前技术应该如何提升,或者以后的职业规划是怎么样的能说说看吗?

   ```objectivec
   提升技术绝非一朝一夕之事,应该是一个长期积累和沉淀的
   短期目标: 进阶为架构师或者大前端工程师
   ```

   

5. 如果要你接手一个新项目,你会如何设计项目架构,不限语言,框架,技术栈

```objectivec
SDK
组件
配置
常量
资源(图片/文件等)
网络
缓存
模块
语言选型 采用xxx xxx 因为 xxx 所以 xxx
```

4. 你从上家公司的离职原因是什么,什么时候离职的?

   ```objectivec
   据实以告,不要贬损上家公司即可
   ```

5. 你最快什么时候到岗?

```objectivec
一周内,不要写马上,不然会显得很着急
```

4. 你现在有没有面试其他公司呢,有`offer`了吗?

   ```objectivec
   应该说一些名气较大的公司 主要是表达求职意向明确 说有offer更佳 毕竟双向选择
   ```

5. 最近有看什么书吗

   ```
   考查是否热爱学习,可举一些例子 在学xxx  分享一段xxx心得体会啥的
   ```

6. `weak`的实现原理,底层什么样的?

  ```objectivec
  hashTable 哈希表, self为键,值为引用的地址数组
  ```

9. `block`用`copy`修饰和用`strong`修饰的区别?

```objectivec
一般用copy修饰,从栈中拷贝到堆上进行操作

在MRC环境中，是不可以的，strong修饰符会对修饰的变量进行retain操作，这样并不会将栈中的block拷贝到堆内存中，而执行的block是在堆内存中，所以用strong修饰的block会导致在执行的时候因为错误的内存地址，导致闪退。

在ARC环境中，是可以的，因为在ARC环境中的block只能在堆内存或全局内存中，因此不涉及到从栈拷贝到堆中的操作。
```

9. 为什么`block`使用`__block`外部变量就能修改它的值?

```objectivec
是将外部局部变量由栈拷贝到堆,改变了内存地址,而不是写操作
```

9. 使用`copy`修饰`NSMutableDictionary`会发生什么?

```objectivec
无法修改字典的值,如果添加键值将会崩溃crash
*** Terminating app due to uncaught exception 'NSUnknownKeyException', reason: '[<__NSFrozenDictionaryM 0x102807690> setValue:forUndefinedKey:]: this class is not key value coding-compliant for the key key.'
```

12. 形如`UIView`动画的block里使用`self`以及通知中心的块语法里使用`self`会循环引用吗?

```objectivec
前者不会,后者会.
UIView的调用的是类方法，当前控制器不可能强引用一个类 ，所以循环无法形成
 //监听对象默认是当前控制器 所以self.view会造成循环持有引用
[[NSNotificationCenter defaultCenter] addObserverForName:@"Test" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        NSLog(@"%@",self.view);
    }];
```

13. 谈谈对设计模式的理解

```objectivec
设计模式六大原则
1.单一职责原则
通俗地讲就是一个类只做一件事
CALayer：动画和视图的显示。
UIView：只负责事件传递、事件响应。

2.开闭原则
对修改关闭，对扩展开放。 要考虑到后续的扩展性，而不是在原有的基础上来回修改

3.接口隔离原则
使用多个专门的协议、而不是一个庞大臃肿的协议，如 UITableviewDelegate + UITableViewDataSource

4.依赖倒置原则
抽象不应该依赖于具体实现、具体实现可以依赖于抽象。 调用接口感觉不到内部是如何操作的

5.里氏替换原则
父类可以被子类无缝替换，且原有的功能不受任何影响 如：KVO

6.迪米特法则
一个对象应当对其他对象尽可能少的了解，实现高聚合、低耦合
```

14. 谈谈`UIView`和`CALayer`的区别

```objectivec
UIView 继承 UIResponder，而 UIResponder 是响应者对象，可以对iOS 中的事件响应及传递，CALayer 没有继承自 UIResponder，所以 CALayer 不具备响应处理事件的能力。CALayer 是 QuartzCore 中的类，是一个比较底层的用来绘制内容的类，用来绘制UI
  
UIView 对 CALayer 封装属性，对 UIView 设置 frame、center、bounds 等位置信息时，其实都是UIView 对 CALayer 进一层封装，使得我们可以很方便地设置控件的位置；例如圆角、阴影等属性， UIView 就没有进一步封装，所以我们还是需要去设置 Layer 的属性来实现功能。
UIView 是 CALayer 的代理，UIView 持有一个 CALayer 的属性，并且是该属性的代理，用来提供一些 CALayer 行的数据，例如动画和绘制。
```

15. 谈谈`KVC`和`KVO`的理解,以及如果需要自己去实现一个`KVO`你会如何去实现

```objectivec
基于runtime的一个键值编码技术,一开始寻找key相关的value 找不到则加下划线,再找不到就抛异常undefinekey:
KVO 键值观察,监听对象的属性,发生值的变化就会响应回调
  
KVO原理实则动态生成一个子类,然后重写setter方法,调用系统方法_NSSetObjectValueAndNotify ,该方法内部调用了willchangeValueForkey , setter赋值, didChageValueForkey 最后observe调用observeValueForKeyPath告诉监听器发生了改变
重写delloc KVO内存释放
```

16. 讲一下`http`和`https`的区别

```objectivec
传输信息安全性不同
http协议：是超文本传输协议，信息是明文传输。如果攻击者截取了Web浏览器和网站服务器之间的传输报文，就可以直接读懂其中的信息。
https协议: 是具有安全性的ssl加密传输协议，为浏览器和服务器之间的通信加密，确保数据传输的安全
 
连接方式不同 
http的连接很简单，是无状态的。
https是由SSL＋HTTP协议构建的可进行加密传输、身份认证的网络协议。  
  
端口不同 
http 80 
https 443
  
证书申请方式不同 
http 证书免费申请
https需要到CA申请证书，一般免费证书很少，需要交费。
```

17. 对于浮点数或者是一个很大的数,你是如何处理的或者计算的?

```objectivec
基本思路是利用字符串模拟两个整数相加的过程
https://blog.csdn.net/anzhi8193/article/details/101352749
```

18. 你认为你的优点和缺点是什么?

```objectivec
挑工作有关的说
优点比较专注能干  缺点xxxx
```

19.  `SDWebImage`实现原理是什么？ 它是如何解决`tableView`的复用时出现图片错乱问题的呢？LRU淘汰算法的实现原理是什么?

```objectivec
根据url查询缓存, 先从内存->磁盘->占位->下载->缓存
UI调用sd_setImageWithURL()
-->接着内部UIView扩展调用sd_internalSetImageWithURL()
--> SDWebImageManager调用loadImageWithURL()
--> SDWebImageCache查找缓存queryDiskCacheForKey()，内存缓存和磁盘缓存
--> SDWebImageDownloader下载图片downloadImage(url, options, progress, completed)
-->返回的图片network result存储到内存或磁盘缓存中storeImage()，便于下次直接从缓存中获取图片
-->获取的图片image显示到UI界面setImage

其实是就是给每个tablecell设置了标识，标识是唯一的，所以不会错乱。和安卓异步加载图片设置tag一样，可以解决图片加载错乱问题。
  
 LRU(最近最少使用): 其实是利用的文件的一个修改时间或者说是使用时间  自动清理至少于最大缓存的一半
```

20. 说一下OC内存管理原理,以及ARC自动释放池释放时机是在什么时候?

```objectivec
谁持有,谁释放,retain+1 release -1 
  
一般情况下，每个接受autorelease消息的对象，都会在下个runloop开始前被释放。也就是说，在一段同步的代码中执行过程中，生成的对象接受autorelease消息后，一般是不会在作用域结束前释放的。
也可以手动干预Autorelease对象的释放时机, 但在手动指定autoreleasepool时, 会在当前作用域大括号结束时释放：
```

21. `TCP`和`UDP`的区别

```objectivec
TCP与UDP区别总结：

1、TCP面向连接（如打电话要先拨号建立连接）;UDP是无连接的，即发送数据之前不需要建立连接
2、TCP提供可靠的服务。也就是说，通过TCP连接传送的数据，无差错，不丢失，不重复，且按序到达;UDP尽最大努力交付，即不保证可靠交付
3、TCP面向字节流，实际上是TCP把数据看成一连串无结构的字节流;UDP是面向报文的
UDP没有拥塞控制，因此网络出现拥塞不会使源主机的发送速率降低（对实时应用很有用，如IP电话，实时视频会议等）
4、每一条TCP连接只能是点到点的;UDP支持一对一，一对多，多对一和多对多的交互通信
5、TCP首部开销20字节;UDP的首部开销小，只有8个字节
6、TCP的逻辑通信信道是全双工的可靠信道，UDP则是不可靠信道
```

22. OC中runtime的消息转发机制的应用场景

```objectivec
动态执行代码
热更新和热重载
崩溃拦截
埋点统计
```

23. 如何解决内存泄漏的? 既然解决过,那么如何写一个这种内存泄漏的bug?

```objectivec
微信读书团队开源的 MLeakFinder 和 Leaks    内存泄漏的本质是循环引用导致内存占用而无法释放

```

24. 如何解决野指针问题? 如何写一个野指针?

```objectivec
使用僵尸对象或者什么什么xxx  本质是已经释放的对象,还被别人访问指向这块内存地址... (俗称鞭尸~)

创建一个对象,然后释放掉,然后去访问它
```

25. 又问如何去实现你的目标?如何去追赶那些优秀的人?

    ```
    诸如职业生涯规划,主要考察有没有主动学习能力啥的
    ```

    

26. 指针的指针是什么

    ```
    指针就是地址,那指针的指针就是指针指向的地址咯
    ```

    

27. C语言中结构体位于栈还是堆?

    ```
    定义出来的时候是存放在堆上的
    局部变量是存放在栈上的
    ```

    

28. 如何收集崩溃日志,如何查看呢,符号表里是什么东西?

    ```
    考察异常处理
    ```

29. iOS技术栈指的是什么?

    ```
    语言,工具,框架等
    ```

    