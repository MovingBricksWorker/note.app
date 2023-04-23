Runtime相关

### 聊聊你对runtime的理解

### 消息转发机制是什么样的？

### 崩溃日志收集你是如何处理的？

### Category底层原理是什么？

### 分类为什么能添加关联对象，不能添加属性，和继承的子类又有什么区别？

### 方法交换实现
hook实在是一个大毒瘤,用的好是利器,稍不注意很容易掉坑里

```
+ (void)bestMethodSwizzlingWithClass:(Class)cls oriSEL:(SEL)oriSEL swizzledSEL:(SEL)swizzledSEL{
    if (!cls) NSLog(@"传入的交换类不能为空");
    Method oriMethod = class_getInstanceMethod(cls, oriSEL);
    Method swiMethod = class_getInstanceMethod(cls, swizzledSEL);
    if (!oriMethod) {
        class_addMethod(cls, oriSEL, method_getImplementation(swiMethod), method_getTypeEncoding(swiMethod));
        // IMP指向了一个空的block方法（空IMP）
        method_setImplementation(swiMethod, imp_implementationWithBlock(^(id self, SEL _cmd){ }));
    }
 
    BOOL didAddMethod = class_addMethod(cls, oriSEL, method_getImplementation(swiMethod), method_getTypeEncoding(swiMethod));
    if (didAddMethod) {
        class_replaceMethod(cls, swizzledSEL, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    }else{
        method_exchangeImplementations(oriMethod, swiMethod);
    }
```

