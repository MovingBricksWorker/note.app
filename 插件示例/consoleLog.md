 {docsify-updated} 
 
```html
<div id="console_log"></div>
<script>
(function () {
      var logger = document.getElementById('console_log');
      console.log = function (message) {
        logger.innerHTML += `<div style="font-family: 'mono-font' !important;margin:15px auto;box-shadow:5px 5px 10px #333;background-color: #000000;color: #42b983;padding:10px 20px;width:fit-content;white-space:normal;margin: 5px ;border-radius: 10px;">${message}</div>`
      }

      console.success = function (message) {
        if (typeof message == 'object') {
          logger.innerHTML += `<div style="background-color: #f0f9eb;color: #67C23A;padding:0px 20px;width:fit-content;white-space:normal;margin: 5px ;border-radius: 10px;">
                <pre style="background-color: transparent  !important; "><code style="font-family: 'mono-font' !important;background-color: transparent  !important;color: #67C23A !important;">${(JSON && JSON.stringify ? JSON.stringify(message, null, 2) : message)}</code></pre>
                </div>` ;
        } else {
          logger.innerHTML += `<div style="background-color: #f0f9eb;color: #67C23A;padding:0px 20px;width:fit-content;white-space:normal;margin: 5px ;border-radius:10px;">
                <pre style="background-color: transparent  !important;"><code style="font-family: 'mono-font' !important;background-color: transparent  !important;color: #67C23A !important;">${(message)}</code></pre>
                </div>` ;
        }
      }

      console.error = function (message) {
        if (typeof message == 'object') {
          logger.innerHTML += `<div style="background-color: #fef0f0;color: #F56C6C;padding:0px 20px;width:fit-content;white-space:normal;margin: 5px ;border-radius: 10px;">
               <pre style="background-color: transparent  !important;"><code style="font-family: 'mono-font' !important;background-color: transparent  !important;color: #F56C6C !important;">${(JSON && JSON.stringify ? JSON.stringify(message, null, 2) : message)}</code></pre>
                </div>` ;
        } else {
          logger.innerHTML += `<div style="background-color: #fef0f0;color: #F56C6C;padding:0px 20px;width:fit-content;white-space:normal;margin: 5px ;border-radius: 10px;">
                <pre style="background-color: transparent  !important;"><code style="font-family: 'mono-font' !important;background-color: transparent  !important;color: #F56C6C !important;">${(message)}</code></pre>
                </div>` ;
        }
      }

      console.warning = function (message) {
        if (typeof message == 'object') {
          logger.innerHTML += `<div style="background-color: #fdf6ec;color: #E6A23C;padding:0px 20px;width:fit-content;white-space:normal;margin: 5px ;border-radius: 10px;">
                <pre style="background-color: transparent  !important;"><code style="font-family: 'mono-font' !important;background-color: transparent  !important;color: #E6A23C !important;">${(JSON && JSON.stringify ? JSON.stringify(message, null, 2) : message)}</code></pre>
                </div>` ;
        } else {
          logger.innerHTML += `<div style="background-color: #fdf6ec;color: #E6A23C;padding:0px 20px;width:fit-content;white-space:normal;margin: 5px ;border-radius: 10px;">
                <pre style="background-color: transparent  !important;"><code style="font-family: 'mono-font' !important;background-color: transparent  !important;color: #E6A23C !important;">${(message)}</code></pre>
                </div>` ;
        }
      }

      console.info = function (message) {
        if (typeof message == 'object') {
          logger.innerHTML += `<div style="background-color: #f4f4f5;color: #909399;padding:0px 20px;width:fit-content;white-space:normal;margin: 5px ;border-radius: 10px;">
                <div style="background-color: transparent  !important;"><div style="font-family: 'mono-font' !important;background-color: transparent  !important;color: #909399 !important;">${(JSON && JSON.stringify ? JSON.stringify(message, null, 2) : message)}</div></div>
                </div>` ;
        } else {
          logger.innerHTML += `<div style="background-color: #f4f4f5;color: #909399;padding:0px 20px;width:fit-content;white-space:normal;margin: 5px ;border-radius: 10px;">
                <div style="background-color: transparent  !important;"><div style="font-family: 'mono-font' !important;background-color: transparent  !important;color: #909399 !important;">${(message)}</div></div>
                </div>` ;
        }
      }

})();
console.log('hello JS');
console.info('hello JS');
console.error('hello JS');
console.success('hello JS');
console.warning('hello JS');
</script>

```


