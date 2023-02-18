使用ElementUI的tooltips组件实现

代码如下: 

```js
<style lang="less" scoped>
   .field{
     display: flex;
     flex-direction: row;
     flex-wrap: nowrap;
     justify-content: flex-start;
   }
   .label-style {
     font-family: PingFangSC-Regular;
     font-size: 14px;
     color: #606266;
     letter-spacing: 0;
     text-align: center;
     line-height: 20px;
     font-weight: 400;
   }
   .content-style {
     display: inline-block;
     overflow: hidden;
     text-overflow: ellipsis;
     white-space: nowrap;
     margin-left: 20px;
     height: 20px;
     width: 300px;
     font-family: PingFangSC-Regular;
     font-size: 14px;
     color: #333333;
     letter-spacing: 0;
     text-align: left;
     line-height: 20px;
     font-weight: 400;
   }
   </style>
   
   <template>
     <div class="field">
       <div class="label-style">
         {{ label }}
       </div>
       <el-tooltip
         :content="`${content}`"
         :disabled="noShowToolTip"
         placement="top"
       >
         <div
           class="content-style"
           @mouseover="onMouseOver"
         >
           {{ content }}
         </div>
       </el-tooltip>
     </div>
   </template>
   
   <script>
   export default {
     props:{
       label:{
         type: String,
         default: ''
       },
       content:{
         type: String,
         default: ''
       }
     },
     data () {
       return {
         noShowToolTip: false,
       };
     },
     methods: {
       onMouseOver (e) {
         const target = e.target;
         this.noShowToolTip = !(target.offsetWidth < target.scrollWidth);
       },
     },
   };
   </script>
```