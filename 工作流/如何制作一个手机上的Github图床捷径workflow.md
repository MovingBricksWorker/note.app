# 如何制作一个手机上的Github图床捷径workflow

* [准备工作](#准备工作)
* [创建捷径](#创建捷径)
* [GitHub API](#github-api)
* [gitee 与 github API如出一辙,不再赘述](#gitee-与-github-api如出一辙不再赘述)
* [总结](#总结)


![如图所见](https://cdn.jsdelivr.net/gh/WangGuibin/MyFilesRepo/images/20210130210239.PNG)

## 准备工作

- `github`账号与绑定邮箱
- 建立一个仓库用于存放图片
- 生成`github token` 注意生成之后要备份以免后面要用到(页面刷新之后会看不见🙈)
- 了解`github`上传文件的 [GitHub API](https://docs.github.com/en/rest/reference/repos?query=content%20is%20not%20valid%20ba%27e#create-or-update-file-contents)

## 创建捷径
-  设置捷径名字,共享表单中显示所有或者图片文件媒体这几种类型
-  创建一个字典存放配置项
-  取出每个配置项作为变量
-  文件名采用时间戳
-  从相册选或者小组件共享获取到图片资源转成`base64`不换行
-  拼接`API`路径,参考`API`和上图
-  `PUT`请求,`json`格式传输,`token`塞进`header`,以及接受类型设置一下即可,值得注意的是`accept`应该设置为`application/vnd.github.v3+json`
-  上传成功之后拼接好`cdn`访问的地址拷贝至剪贴板


## GitHub API
```bash
 https://api.github.com/repos/<userName>/<repoName>/contents/<path>/<fileName>
 PUT 请求 
 header 里
 {
      "Accept" : "application/vnd.github.v3+json",
      "Authorization" : "token <github token>" 
}

json必传的两个参数
{ 
"message" : 提交日志信息,
"content" : 文件以base64形式不换行 
}

<!-- 免费的CDN小技巧 https://cdn.jsdelivr.net/gh/<username>/<repoName>/xxx/   -->
 ```

## gitee 与 github API如出一辙,不再赘述

## 总结
灵感来自于`PicGo`,`Mac`上有这样一个软件插件挺好的,就想着好多图片都来自于手机拍摄,所以干脆就寻思着做了这么一个工具,直接从手机端上传,把地址放到剪贴板,剪贴板工具`Pin`或者其他工具通过`iCloud`同步到`Mac`使用也是可以达到无缝使用. (之前也有很多其他平台的图床用于盆友圈图片评论啥的,原理其实都是一个道理,把图片上传到图床取链接而已)