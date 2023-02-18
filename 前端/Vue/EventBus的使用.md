使用eventBus优化组件之间的传参
```js
import Vue from 'vue';

//eventBus 用于跨组件通信
let eventBus = new Vue();
Vue.prototype.$eventBus = eventBus;
export default eventBus;

// 用法如下:
//  import eventBus from '@/utils/eventBus';
//发布侧
// eventBus.$emit('xxx',params);

//订阅侧
// eventBus.$on('xxx',(params)=>{
//    console.log('接收到参数: ',params);
// });
```