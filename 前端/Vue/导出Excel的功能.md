!> 说是导出,实际上为下载文件

##### 基于`axios`下载文件

`responseType`需设置`blob`的格式,然后从请求头里获取到文件名进行下载

```js
function downloadFile (url,params,method,headers={}) {
  return axios({
    method: method,
    url: `${process.env.VUE_APP_BASE_API}${url}`,
    data: method.toLocaleLowerCase()==='post' && params,
    params: method.toLocaleLowerCase()==='get' && params,
    responseType: 'blob',
    headers: headers
  });
}

let params = {
        ... 
      };

      downloadFile('xxxx/xxxx', params, 'post').then(res => {
        const filename = decodeURIComponent(res.headers['content-disposition'].match(/filename=(.*)/)[1]);
        executeDownload(res.data, filename);
      }).catch(eroro => {
        this.$message({
          type: 'error',
          message: '文件下载失败：' + eroro.message
        });
      });

//  模拟点击a 标签进行下载
export function executeDownload (data, fileName) {
  if (!data) {
    return;
  }
  const url = window.URL.createObjectURL(new Blob([data]));
  const link = document.createElement('a');
  link.style.display = 'none';
  link.href = url;
  link.setAttribute('download', fileName);
  document.body.appendChild(link);
  link.click();
  document.body.removeChild(link);
}
```

pdf文件预览和下载

> 预览: 预览是浏览器自己的功能 只要是pdf文件的链接被识别为pdf文件格式就会加载预览界面,也可以使用iframe加载设置src为pdf的文件链接即可

```js
window.open(`http://xxxx/yuv.pdf`);
```
   
> 下载: 需要把响应方式改为二进制blob

```js
   axios({
     method: 'get',
     url: `${process.env.VUE_APP_BASE_API}/yuv.pdf`, //测试一下 我放到public目录下了 不然跨域
     responseType: 'blob',//这一步很关键
   }).then((res) => {
     // const filename = decodeURIComponent(res.headers['content-disposition'].match(/filename=(.*)/)[1]);
     //模拟a标签点击下载
     executeDownload(res.data,'YUV.pdf');
   }).catch((err) => {
   
   });
   
```
   