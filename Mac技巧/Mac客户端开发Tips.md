
### 通过`NSTask`执行命令行或者可执行文件
放到`main bundle`里的可执行文件是可以被执行的,打包之后会放在`Resources`目录下
不过编译之前需要提高权限
```bash
# PatchGenerator为一个命令行工具 需要提升权限 沙盒里才能运行 
# 不然控制台会提示一个错误信息 执行不下去 `[General] launch path not accessible`
chmod +x PatchGenerator
#加上权限之后 记得clean一下再编译就行了
```

```objc
//使用NSTask调用shell https://www.cnblogs.com/JanaChen/p/5883966.html
//MacOS 开发 - NSTask（调用命令行、APP 多开） https://blog.csdn.net/lovechris00/article/details/78145937

/// 运行命令行
/// - Parameters:
///   - args: 参数列表
///   - cmdPath: 环境所在路径 即可执行文件所在
- (NSString *)runCommandWithArgs:(NSArray *)args
                   cmdPath:(NSString *)cmdPath
{
    NSLog(@"%@",args);
    
    NSTask *task;
    task = [[NSTask alloc] init];
    [task setLaunchPath: cmdPath];
    [task setArguments: args];
    
    NSPipe *pipe;
    pipe = [NSPipe pipe];
    [task setStandardOutput: pipe];
    
    NSFileHandle *file;
    file = [pipe fileHandleForReading];
    
    [task launch];
    
    NSData *data;
    data = [file readDataToEndOfFile];
    
    NSString *log;
    log = [[NSString alloc] initWithData: data
                                   encoding: NSUTF8StringEncoding];
    return log;
}

```
示例如下: 
```objc
//通过终端bash的open命令打开指定目录 
NSString *cmdPath = @"/bin/bash";
NSString *cmd = [NSString stringWithFormat:@"open %@",self.outputDirTF.stringValue];
NSArray *arguments = [NSArray arrayWithObjects:@"-c",cmd,nil];
[self runCommandWithArgs:arguments cmdPath:cmdPath];

```
来个复杂点的 (传递多个参数) 
```objc
//可执行文件
NSString *cmdPath = [[NSBundle mainBundle] pathForResource:@"PatchGenerator" ofType:@""];
//引用文件所在目录
NSString *refsPath = [[NSBundle mainBundle] pathForResource:@"Scripts" ofType:@"bundle"];
//文件输出目录
NSString *ouptputBinaryPath = [NSString stringWithFormat:@"%@/binarypatch",self.outputDirTF.stringValue];
// 参数数组可以理解为shell传参的时候的每一个空格就是每一个参数的分隔符 对应的这里就是`arguments`数组的每一个元素
NSArray *arguments = [NSArray arrayWithObjects:cmd,@"-files",self.packDirTF.stringValue,@"-refs",refsPath,@"-output",ouptputBinaryPath,nil];
NSString *log = [self runCommandWithArgs:arguments cmdPath:cmdPath];
NSLog(@"%@",log);
```


### 打开选择选择文件或者文件夹的对话框

可以对应修改属性实现对应的需求

```objc
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    panel.prompt = @"选择";
    panel.title = @"选择目录";
    panel.canChooseDirectories = true;
    panel.canChooseFiles = false;
    panel.allowsMultipleSelection = NO;
    panel.resolvesAliases = NO;
    panel.canCreateDirectories = YES;
    panel.directoryURL = [NSURL URLWithString: NSHomeDirectory()];
    [panel beginWithCompletionHandler:^(NSModalResponse result) {
        if(result == 1){
            //拿到选择的URL路径
            NSURL *url = [panel.URLs firstObject];
        }
    }];
```

###  NSAlert 弹窗
类似于`Applescript`调用出来的`dialog`弹窗,具体可以参考 [这篇文章](Mac技巧/关于AppleScript脚本语言的一些使用总结.md),当然也可以使用命令行调用`Applescript`弹窗,就是一层调一层,太麻烦就是了

```objc
/// 提示消息
/// - Parameters:
///   - buttonTitle: 按钮
///   - messageText: 标题
///   - informativeText: 消息
- (void)showAlertButtonTitle:(NSString *)buttonTitle
                 messageText:(NSString *)messageText
             informativeText:(NSString *)informativeText
                   isWarning:(BOOL)isWarning callback:(dispatch_block_t)callback{
    NSAlert *alert = [[NSAlert alloc] init];
    alert.alertStyle = isWarning? NSAlertStyleCritical : NSAlertStyleWarning;
        [alert addButtonWithTitle:buttonTitle];
        alert.messageText = messageText;
        alert.informativeText = informativeText;
        [alert beginSheetModalForWindow:[NSApplication sharedApplication].keyWindow completionHandler:^(NSModalResponse returnCode) {
            !callback? : callback();
        }];
}
```

