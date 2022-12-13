tooltips 每一项数据鼠标移动到该位置进行动态显示并自定义显示

```js
tooltip: {
          trigger: 'axis',
          formatter: function (params) {
            let str = params[0].name + '<br/>';
            params.forEach((item) => {
              const itemValue = needDisplayUnit? prettyBytes(item.value) : item.value;
              str +=
                '<span style="display:inline-block;margin-right:5px;border-radius:50%;width:10px;height:10px;left:5px;background-color:'+item.color+'"></span>' + item.seriesName + ' : ' + itemValue + '<br />';
            });
            return str;
          }
        },
```



调图形边距

```js
grid: {
          left: 11,
          right: 22,
          top: 10,
          bottom: 0,
          containLabel: true
        },
```



横轴

```js
xAxis: {
          type: 'category',
          boundaryGap: false,
          data: this.times,
          axisTick: {
            show: false,
          },
          axisLine:{
            lineStyle:{
              color:'#909399',
              cap: 'square',
            },
          },
        },
```



纵轴

```js
yAxis: {
          type: 'value',
          nameTextStyle: {
            color: '#eee',
          },
          splitLine: {
            lineStyle: {
              color: '#eee',
            }
          },
          axisLabel:{
            formatter: (value) => {
              return this.needDisplayUnit? `${prettyBytes(value)}` : value;
            },
          }
        },
```

`LineChart`组件完整代码

```js
<template>
  <div
    id="pChart"
    class="line"
  >
    <div
      id="myChart"
      ref="thireShow"
      style="height: 300px;width: 100%;"
      class="pic"
    />
  </div>
</template>
<script>

const echarts = require('echarts');
import prettyBytes from 'pretty-bytes';

export default {
  props: {
    needDisplayUnit:{
      type : Boolean,
      default: true
    },
    times:{
      type : Array,
      default: () => [] //[HH:mm:ss] 时间轴
    },
    series:{
      /*
       [
        {
            name: 'cpu',//数据项
            type: 'line',//图类型
            smooth: true,
            showSymbol: false,
            areaStyle: {
              normal: {
                origin:'start',
                color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                  { offset: 0, color: 'rgba(2,121,255,0.2)' },
                  { offset: 1, color: 'rgba(255,255,255,0)' }
                ])
              }
            },
            lineStyle: {
              color: '#0279FF',
              width: 3
            },
            data: datas
          }
      ]
      */
      type : Array,
      default: () => []
    }

  },
  data (){
    return{
      myChart: null
    };
  },
  watch: {
    series (val){
      this.show ();
    },
  },
  mounted (){
    this.myChart = echarts.init(this.$refs.thireShow);
  },
  destroyed (){
    // 挂在echarts的节点被销毁后，销毁echarts的实例
    if (this.myChart) {
      this.myChart.dispose();
      this.myChart = null;
    }
  },
  methods: {
    async show (){
      await  document.getElementById('myChart').removeAttribute('_echarts_instance_');
      await this.trend ();
    },

    trend (){
      if(!this.myChart){
        this.myChart = echarts.init(this.$refs.thireShow);
      }
      let needDisplayUnit = this.needDisplayUnit;
      var option = {
        tooltip: {
          trigger: 'axis',
          formatter: function (params) {
            let str = params[0].name + '<br/>';
            params.forEach((item) => {
              const itemValue = needDisplayUnit? prettyBytes(item.value) : item.value;
              str +=
                '<span style="display:inline-block;margin-right:5px;border-radius:50%;width:10px;height:10px;left:5px;background-color:'+item.color+'"></span>' + item.seriesName + ' : ' + itemValue + '<br />';
            });
            return str;
          }
        },
        axisPointer: {
          animation: false
        },
        grid: {
          left: 11,
          right: 22,
          top: 10,
          bottom: 0,
          containLabel: true
        },
        xAxis: {
          type: 'category',
          boundaryGap: false,
          data: this.times,
          axisTick: {
            show: false,
          },
          axisLine:{
            lineStyle:{
              color:'#909399',
              cap: 'square',
            },
          },
        },
        emphasis: {
          // 鼠标hover上去的时候，拐点的颜色和样式
          itemStyle: {
            // color: '#fff', //颜色
            borderColor: '#286EF0 ', //图形的描边颜色
            borderWidth: 2, // 描边的线宽
            shadowBlur: 1, // 图形的阴影大小
            shadowColor: '#286EF0 ', // 图形的阴影颜色
          },
        },
        yAxis: {
          type: 'value',
          nameTextStyle: {
            color: '#eee',
          },
          splitLine: {
            lineStyle: {
              color: '#eee',
            }
          },
          axisLabel:{
            formatter: (value) => {
              return this.needDisplayUnit? `${prettyBytes(value)}` : value;
            },
          }
        },
        series: this.series
      };
      option && this.myChart.setOption(option);
      var _self = this;
      setTimeout(function (){
        window.onresize = function (){
          _self.myChart.resize();
        };
      },200);
    },
  },
};
</script>
<style lang='less' scoped>
.line{
  height: calc(~'100% - 10px');
}
</style>
```