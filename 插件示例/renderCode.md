**React渲染**

```html
/*react*/
<desc>
Hello `world`
* a
* b
</desc>
<style>
  .author {
    color: #ff0000cc;
  }
</style>
<script>
  export default class Application extends React.Component {
    constructor(props) {
      super(props)
      this.state = {
        color: 'blue'
      }
      this.globalVariable = globalVariable
    }
    render() {
      return (
        <div>
          <div className='wrapper' ref={el => this.el = el}>
            <div>
            <p className='author'>author: {this.globalVariable}</p>
            <button style={{color: this.state.color}} className='test' onClick={e => {alert('author: ' + this.globalVariable); this.setState({color: 'red'})}}>test</button>
            </div>
          </div>
        </div>
      )
    }
  }
```

**Vue渲染**

<style>
    .select_bg {
      display: inline-block;
      position: relative;
      font-size: 18px;
      height: 3.2rem;
      width: auto;
      background: #fff;
      box-sizing: border-box;
      border-radius: 1rem;
    }

    .select_bg select {
      border-radius: 5px;
      width: 100%;
      border: 1px solid #999;
      background: transparent;
      background-image: none;
      -webkit-appearance: none;
      -moz-appearance: none;
      vertical-align: top;
      padding: 0.8rem;
    }

    .select_bg select:focus {
      outline: none;
    }

    #list-data {
      background-color: rgb(245, 245, 245);
      margin-top: 30px;
      padding: 1rem;
    }

    .list-item {
      margin: 15px 0;
      box-shadow: 5px 5px 15px #999;
      border-radius: 15px;
      padding: 1rem;
    }

    .row-item {
      display: flex;
      direction: row;
      justify-content: flex-start;
      align-items: center;
      margin-left: 10px;
    }

    #signed-mark {
      width: 10px;
      height: 10px;
      border-radius: 5px;
      background-color: #999;
      margin: 0 10px;
      position: absolute;
      right: 30px;
    }
  </style>
   
 <div id="app">
    <div style="display: flex;">
      <div class="select_bg">
        <select name="device" id="device" @change="selectDevice">
          <option value="none">请选择你的设备</option>
          <option v-for="(item,index) in devices" :key="index" :value="item.identifier">
            {{item.name}}
          </option>
        </select>
      </div>
      <div v-if="name.length"
        style="white-space: nowrap;margin-left: 20px;width: 300px;height: 3.6rem;line-height: 3.6rem;font-size: 18px;font-weight: bold;">
        <span>{{name}}</span>(<span>{{identifier}}</span>)
      </div>
    </div>
    <div id="list-data" v-if="firmwares.length">
      <div v-for="(ipsw,index) in firmwares" :key="index">
        <div class="list-item" @click="openLink(ipsw)">
          <div class="row-item" style="font-size: 18px; font-weight: bold;"><span>{{sys}} {{ipsw.version}}</span><span>
              ({{ipsw.buildid}})</span></div>
          <div class="row-item" style="font-size: 12px;margin-top: 10px;position: relative;">
            {{calculateFileSize(ipsw.filesize)}}
            {{ipsw.releasedate}}<span id="signed-mark" :style="markStyle(ipsw)"></span><a :href="ipsw.url"
              target="_blank" style="text-decoration: none;position:absolute;right: 10px;">下载</a>
          </div>
        </div>
      </div>
    </div>
    </div>
    <script>
    new Vue({
      el: '#app',
      data() {
        return {
          name: '',
          sys:'iOS',
          identifier: '',
          firmwares: [],
          devices: [],
        }
      },
      mounted() {
        this.getDevices();
      },
      methods: {
        getSystemName(identifier){
            const systemName = identifier.replace(/[0-9,]+/g,'');
            if (systemName.includes('iP')) {
                this.sys = 'iOS'
            } else if(systemName.includes('Mac')){
                this.sys = 'MacOS'
            }else{
                this.sys = systemName;
            }
        },
        openLink(ipsw) {
        window.open(ipsw.url, '_blank');
        },
        markStyle(ipsw) {
          return {
            backgroundColor: ipsw.signed ? '#1eab00' : '#999'
          }
        },
        calculateFileSize(size) {
          const fileSize = (size / 1024.0 / 1024.0 / 1024.0).toFixed(1);
          return fileSize + "G";
        },
        selectDevice(e) {
            const idf = e.target.value;
            if (idf === 'none') {
            this.name = '';
            this.sys = '';
            this.identifier = '';
            this.firmwares = [];
            } else {
                this.getIPSWInfo(idf);
            }
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
        getIPSWInfo(identifier) {
          let that = this;
          this.ajaxGetData(`https://api.ipsw.me/v4/device/${identifier}?type=ipsw`, function (data) {
            let obj = JSON.parse(data);
            that.name = obj.name;
            that.getSystemName(identifier);
            that.identifier = identifier;
            that.firmwares = obj.firmwares;
          })
        },
        getDevices() {
          let that = this;
          this.ajaxGetData('https://api.ipsw.me/v4/devices', function (data) {
            that.$nextTick(() => {
              that.devices = JSON.parse(data);
            });
          })
        }
      }
    })
  </script>
