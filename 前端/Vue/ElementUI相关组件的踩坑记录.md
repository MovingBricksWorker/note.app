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