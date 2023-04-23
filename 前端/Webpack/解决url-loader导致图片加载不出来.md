```js
// 解决部分图片无法显示问题 src="[object Module]"
    config.module.rule('images')
      .test(/\.(png|jpe?g|gif|svg)$/)
      .use('url-loader')
      .loader('url-loader').options({
        esModule: false,
        limit: 1024*10,// 小于10k的图片采用baseurl，大于和等于8k的就正常打包成图片
        name:'img/[name].[ext]'//图片大于等于10k时，设置打包后图片的存放位置 name是文件名   ext是文件后缀
      });
```