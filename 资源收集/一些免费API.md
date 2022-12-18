- 新闻资讯
https://static001.geekbang.org/univer/classes/ios_dev/lession/45/toutiao.json

- mp4测试链接🔗
http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4

- 每日早报
https://cdn.jsdelivr.net/gh/WangGuibin/weather-action@master/logs/{yyyy-mm-dd}.txt

- [天气接口 · 免费API接口 · 看云](https://www.kancloud.cn/lizhixuan/free_api/1159533)

- bilibili
https://github.com/SocialSisterYi/bilibili-API-collect

- 网抑云
https://github.com/Binaryify/NeteaseCloudMusicApi

- 自定义mock
https://designer.mocky.io/design

- [数学乐](https://www.shuxuele.com/index.html)

- [苹果软件站-美区ID共享](https://www.iios.me/login)
- [企业证书](https://apporanges.lanzoui.com/b0cfcmzwj)
- [轻松签](https://esign.yyyue.xyz/)


<div id="app" style="text-align:left;white-space: pre-line;background-color:#00000033;padding:20px;border-radius:15px;color:#333;">
{{log}}
</div>
<script>
    new Vue({
      el: '#app',
      data() {
        return {
          log: ''
        }
      },
      mounted() {
        this.getDayLog();
      },
      methods: {
        formatDate (date) {
            var yyyy = date.getFullYear().toString();
            var mm = (date.getMonth() + 1).toString();
            var dd = date.getDate().toString();
            return yyyy + "-" + (mm[1] ? mm : "0" 
            + mm[0]) + "-" + (dd[1] ? dd : "0" + dd[0]);  
        },
        getDayLog(){
            let that = this;
            const dateStr = this.formatDate(new Date()); 
            this.ajaxGetData(`https://cdn.jsdelivr.net/gh/WangGuibin/weather-action@master/logs/${dateStr}.txt`, function (data) {
            that.log = data;
          })
        },
        ajaxGetData(url, cb) {
          let request = new XMLHttpRequest();
          request.open('GET', url, true);
          request.onreadystatechange = function () {
            if (this.readyState === 4 && this.status === 200) {
              cb(this.responseText);
            }
          }
          request.send();
        },
      }
    })
  </script>

