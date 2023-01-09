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

