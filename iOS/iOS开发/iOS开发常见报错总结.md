1. 编译报错`Undefined symbol: ___gxx_personality_v0`

> [!NOTE]
> 解决办法:  `Other Linker Flags`添加`-lstdc++`即可



2. 编译报错`Too many personality routines for compact unwind to encode`

> [!NOTE]
> 解决办法:  `Other Linker Flags`添加`-Wl,-no_compact_unwind`即可

pod的话添加如下设置

```ruby
post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['OTHER_CFLAGS'] = '-Wl,-no_compact_unwind'
        end
    end
end 
```

3. 编译报错`error build: 1 duplicate symbol for architecture arm64`

> [!NOTE]
> 解决办法:  检查头文件是否.h变成了.m 写错了 或者 看看有没有这个文件或者这个方法
> 点开编译堆栈看看 上一次c的一个函数和宿主App写的一样也报这个错~
