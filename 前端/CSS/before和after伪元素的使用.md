其实`:before`和`:after`算不上是`dom`节点元素
可以利用伪元素实现一些旁门左道&&奇技淫巧,css动画,画图,图标以及一些转场效果等

## 用法一 清除浮动 BFC

```css
.clearfloat:after{
    display:block;
    clear:both;
    content:'';
    visibility:hidden;
    height:0;
} 
.clearfloat{
    zoom:1; /*这行可以不写 貌似是兼容IE6的  现如今IE为何物? 大清都亡了 滚犊子吧*/
} 

```


## 用法二 画线
画下划线可能会有很多种方法: 
① 底部边框`bottom-border`
② 使用 `hr` 标签 或者是其他三方组件
③ 自己画个`div`,调整样式
④ 使用伪元素 `:before` 和 `:after`
 
```css
.box{
    position: relative;
    height: 48px;
    font-family: PingFangSC-Regular;
    font-size: 14px;
    color: #333333;
    letter-spacing: 0;
    line-height: 48px;
    padding: 0 45px;
}

/*画一根左边线*/
.box:before{
        display:block;
        content:'';
        position:absolute;
        bottom: 0px;
        top: 0px;
        left: 0px;
        width: 1px;
        height:100%;
        background-color:rgba(240,240,240,1);
        z-index: 1;
}
/*画底部线*/
.box:after{
        display:block;
        content:'';
        position:absolute;
        bottom: 0px;
        left: 0px;
        right: 0px;
        width: 100%;
        height:1px;
        background-color:rgba(240,240,240,1);
 }

```

<style>
.box{
    position: relative;
    height: 48px;
    font-family: PingFangSC-Regular;
    font-size: 14px;
    color: #333333;
    letter-spacing: 0;
    line-height: 48px;
    padding: 0 45px;
}

/*画一根左边线*/
.box:before{
        display:block;
        content:'';
        position:absolute;
        bottom: 0px;
        top: 0px;
        left: 0px;
        width: 1px;
        height:100%;
        background-color:rgb(30,120,255);
        z-index: 1;
}
/*画底部线*/
.box:after{
        display:block;
        content:'';
        position:absolute;
        bottom: 0px;
        left: 0px;
        right: 0px;
        width: 100%;
        height:1px;
        background-color:rgb(30,120,255);
 }
</style>
<div class="box">
    :before 和 :after 的用法还有很多,需要通过实践逐步掌握~
</div>