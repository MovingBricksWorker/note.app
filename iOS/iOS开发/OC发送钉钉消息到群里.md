1. 需要建立这样一个钉钉群
2. 新增一个机器人🤖,并获取webhook链接🔗
3. 编写收消息规则
4. 编写代码

```objc
///MARK:- 发送钉钉消息给开发者
- (void)sendMsgToDingTalkWithMessage:(NSString *)message{
    ///直达钉钉群
    NSString *token = @"xxxx";
    NSString *urlStr = [NSString stringWithFormat:@"https://oapi.dingtalk.com/robot/send?access_token=%@",token];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"UTF-8" forHTTPHeaderField:@"Charset"];
    req.HTTPMethod = @"POST";
    NSDictionary *body = @{
        @"msgtype":@"text",
        @"text" : @{
                @"content":message
        },
        @"at" : @{
                @"isAtAll" : @(1)  //@所有人
        }
    };
    req.HTTPBody = [NSData dataWithData:body.modelToJSONData];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"%@",dic.modelToJSONString);
            }else{
                NSLog(@"%@",error);
            }
        });
    }];
    [task resume];
}

```


应用场景是测试环境,出现BUG时及时响应到开发把堆栈日志直接发出来,减少一定的沟通成本