## Table

#### 自定义渲染表头
```jsx
<el-table-column prop="xxx" label="xxx" :render-header="renderHeader"/>
renderHeader (h, { column,$index}) {
      return h('div', {
        attrs: {
          class: 'cell'
        },
        domProps: {
          innerHTML: `<span style="margin:${20-$index*7}px;"></span>` + column.label
        }
      });
 }
```

#### 修改表头单元格样式
```jsx
<el-table
      :data="brokerDatas"
      style="width: 100%"
      :header-cell-style="headerCellStyle"
    >
  ...
headerCellStyle ({ row, rowIndex}){
 return 'background-color:#fafafa;color:#606266';
}

```

#### 自定义单元格样式
```jsx
 <el-table
      class="list"
      :data="data"
      style="width: 100%"
      :cell-class-name="rowStyle"
    >
    ...

//设置第二列的样式类名
    rowStyle (row){
      if(row.columnIndex === 1){
        return 'custom-column';
      }
    }
```

#### 消除Table组件数据列单元格自带的内边距 
消除了默认内边距 更方便自定义cell
```css
/deep/ .el-table tbody .el-table__cell{
  padding: 0;
}
```

#### 单元格整体调整margin
```css
/deep/.el-table .cell{
  margin-left: 10px;
}
```


## Dialog
自定义弹窗
需要用到.sync语法糖进行双向绑定
```jsx
<template>
  <el-dialog
    title="xxx"
    append-to-body
    :before-close="onClose"
    :visible.sync="visible"
    width="360px"
    height="500"
  >
    <div class="content">
      <div>
        xxxxx一堆展示的东西或者表单啥的自定义都行~
      </div>
   
      <div
        class="save-btn"
        @click="saveAction"
      >
        保存
      </div>
    </div>
  </el-dialog>
</template>

<script>
export default {
  name:"MyDialog",
  props:{
    visible:{
      type: Boolean,
      default: false
    }
  },
  methods: {
    onClose () {
      this.$emit('update:visible', false);
    },
    saveAction (){
      this.$emit('update:visible', false);
    }
  },
};
</script>

//父组件调用 只需定义一个布尔值变量visible即可 
<MyDialog
 :visible.sync="dialogVisible"/>
//visible默认false即不显示弹窗 点击按钮或者什么事件响应延时啥的 修改visible为true 弹窗就会显示  
```


## Select

##### El-select选择数据后不回显的问题

`el-select`选择某个选项时,不回显的问题,实际上值已经变了,但是没有及时刷新出来,点击其他的`select`之后才会显示出来,这一类问题可以采用强制刷新的方式

`$set`修改数据源进行驱动或者`this.$forceUpdate();`

```js
  //修改form里的layer字段 设置对应key 的 value即可
  this.$set(this.form,'layer',val.layerName);
```
