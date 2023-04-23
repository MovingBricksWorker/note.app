1. 首先下载两个微信SDK,一个具备支付功能完整版本,另一个不具备支付功能的轻量版本
2. 在项目根目录新建一个目录,命名为`WeiXinOpenSDK`, 存放这两个`SDK`,一个叫`OpenSDK`,另一个叫`OpenSDKNoPay`,其实内部文件结构一致,只是`.a`大小不一,其次就是请求类和响应类有无支付相关的类的区别
3. 创建一个`WeiXinOpenSDK.podspec`文件用于描述本地库的一个规则

`目录结构如下`:

```bash
.
├── OpenSDK
│   ├── WXApi.h
│   ├── WXApiObject.h
│   ├── WechatAuthSDK.h
│   └── libWeChatSDK.a
├── OpenSDKNoPay
│   ├── WXApi.h
│   ├── WXApiObject.h
│   ├── WechatAuthSDK.h
│   └── libWeChatSDK.a
└── WeiXinOpenSDK.podspec

```

4. 编写`.podspec`文件

```ruby
Pod::Spec.new do |s|
  s.name                  = 'WeiXinOpenSDK'
  s.version               = '2.0.2' #对标微信开放平台的2.0.2微信sdk版本
  s.license               = 'MIT'
  s.summary               = '微信SDK'
  s.homepage              = 'https://xxxxxx'
  s.author                = { 'CoderWGB' => 'xxx' }
  s.source                = { :file => './WeiXinOpenSDK.podspec', :tag => "v#{s.version}" }
  s.requires_arc          =  true  
  s.ios.deployment_target = '10.0'
  s.default_subspec = 'OpenSDK' #具备支付功能  不上AppStore时打开
  #s.default_subspec = 'OpenSDKNoPay' #不具备支付功能 上AppStore时打开

  #完整版 具有支付功能
  s.subspec 'OpenSDK' do | ss |
    ss.source_files = 'OpenSDK/*'
    ss.vendored_libraries = 'OpenSDK/libWeChatSDK.a'
    ss.public_header_files = 'OpenSDK/*.h'
    #通过配置预编译宏进行区分 做到只修改一行代码 pod install一下就可以切换微信SDK
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) WXPAY_VERSION=1'
    }
  end
  #轻量版 没有支付功能
  s.subspec 'OpenSDKNoPay' do | ss |
    ss.source_files = 'OpenSDKNoPay/*'
    ss.vendored_libraries = 'OpenSDKNoPay/libWeChatSDK.a'
    ss.public_header_files = 'OpenSDKNoPay/*.h'
    ss.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) '
    }
  end

end

```

5. 在调用微信支付的地方,做一下预编译宏的判断,比如获取参数,组装微信对象参数以及回调的地方,凡是涉及到微信支付类的地方加一下判断就OK

例如: 

```objc
#ifdef WXPAY_VERSION
//组装微信支付参数
+ (PayReq *)converWXReq:(AKGetChargeModel *)res;
#endif

- (void)onResp:(BaseResp *)resp
{
    //通过预编译宏 编译阶段区分开 避免被苹果扫出来
#ifdef WXPAY_VERSION
    if ([resp isKindOfClass:[PayResp class]]) {
        NSString *message = @"";
        if(resp.errCode == 0){
            message = @"支付成功";
        }else if (resp.errCode == -2){
            message = @"已取消支付";
        }else{
            message = @"支付失败";
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"AKWXPaySuccessFlag" object:@{
            @"isSuccess": @(resp.errCode == 0),
            @"message": [NSString stringWithFormat:@"%d %@",resp.errCode,message]
        }];
    }
#endif
}

```

6. 通过修改`.podspec`的`default_subspec`进行切换`SDK`,每次修改重新`install`即可


##### 以上便是实践的全过程了,唯一的难点就是`.podspec`文件的编写,一些规则比较晦涩,有一定的学习成本