---
title: CSS学习笔记
date: 2017-09-26 22:25:24
categories: 记录篇
tags: [CSS,学习笔记,前端基础]
---

##  选择器的使用
- 类选择器和id选择器用法类似,类选择器可以选择多个标签,标签也可以拥有多个类选择器,类还可以继承,以及伪类等使用,而id不同,id是标签唯一的标识,id选择器可以指向多个标签,但是一个标签只能对应一个id。
- css样式的优先级, 外部 `<` 内嵌 `<` 内联, 也就是谁离控制的标签距离越近(按文档流的方向)就听谁的,谁的样式就好使,不然都得被后来者居上,覆盖之。 
-  `*{ … }`  通用选择器  
- `food >li `子类选择器
- 伪类选择符 鼠标滑过 显示的效果样式..
```
 a:hover{color:red;}
```
<!-- more -->

- 段落缩进
```
 p{text-indent:2em;}
```

- 行高(行间距)  : 设置垂直居中一般就用到这个货~
```
p{line-height:1.5em;}
```

- 文字间隔
``` 
h1{
    letter-spacing:50px;
}
```
- 布局属性text-align (left,center,right) 与iOS差不多
-  常用的块状元素有：
```javascript
<div>、<p>、<h1>...<h6>、<ol>、<ul>、<dl>、<table>、<address>、<blockquote> 、<form>
```
- 常用的内联元素有：
```
<a>、<span>、<br>、<i>、<em>、<strong>、<label>、<q>、<var>、<cite>、<code>
```
- 常用的内联块状元素有：
```
<img>、<input>
```
- 将div等块元素转换成内联元素
```
 div{display:inline;}
<div style="color:red">我是谁</div><br>
```

-   盒子模型
填充也可分为上、右、下、左(顺时针)。如下代码：
```
div{padding:20px 10px 15px 30px;}
```
顺序一定不要搞混。可以分开写上面代码：
```
div{
   padding-top:20px;
   padding-right:10px;
   padding-bottom:15px;
   padding-left:30px;
}
```
这上右下左也是醉了 和苹果的(上左下右)刚好相反      一个顺时针  一个逆时针
如果上、右、下、左的填充都为`10px`;可以这么写
```
div{padding:10px;}
```
如果上下填充一样为`10px`，左右一样为`20px`，可以这么写：
```
div{padding:10px 20px;}
```
- 想要让多个块级元素单行显示咋办
```
display:  inline--block;
```
- 水平居中的方法
```
标准流,文本居中即可
定位流中设置  position: relative;     left: (100% -- 元素宽度)/2 ;
浮动流中设置  margin:  0  auto;  
```
- 盒子模型定位技巧
```
display: block;
包括内边距(padding)和外边距(margin)以及边框(boder)
 display: flex; 支持flex-box布局属性灵活弹性布局

1. flex-direction： 主轴的方向（即项目的排列方向）。 【box-orient】
2. flex-wrap： 如果一条轴线排不下，如何换行。 【box-lines】
3. flex-flow： flex-direction属性和flex-wrap属性的简写形式，默认值为row nowrap
4. justify-content： 项目在主轴上的对齐方式。【box-pack】
5. align-items： 项目在交叉轴上如何对齐。【box-align】
6. align-content： 定义了多根轴线的对齐方式。如果项目只有一根轴线，该属性不起作用。
```

- 定位
`absolute`:表里如一，移动了就是移动了。
`relative`:只是表面显示移动了，但实际还在文档流中原有位置，别的元素无法占据。
`fixed`:传说中的右下角悬浮小广告。
`Relative`与`Absolute`组合使用：子元素定位时，它的前辈元素必须设置有`position`属性，从而子元素使用`absolute`进行定位
 结合 `left` `top` `right` `bottom`可以灵活各种布局的定位


# 清除浮动的小技巧
###  1. 父级div定义 height 
```html
<style type="text/css"> 
.div1{background:#000080;border:1px solid red;/*解决代码*/height:200px;} 
.div2{background:#800080;border:1px solid red;height:100px;margin-top:10px} 
.left{float:left;width:20%;height:200px;background:#DDD} 
.right{float:right;width:30%;height:80px;background:#DDD} 
</style> 
<div class="div1"> 
<div class="left">Left</div> 
<div class="right">Right</div> 
</div> 
<div class="div2"> 
div2 
</div> 
```
- **原理：**`父级div手动定义height，就解决了父级div无法自动获取到高度的问题。` 
- **优点：**`简单、代码少、容易掌握 ``
- **缺点：**`只适合高度固定的布局，要给出精确的高度，如果高度和父级div不一样时，会产生问题 `
- **建议：**`不推荐使用，只建议高度固定的布局时使用 `

###  2. 结尾处加空div标签 clear:both
```css
<style type="text/css"> 
.div1{background:#000080;border:1px solid red} 
.div2{background:#800080;border:1px solid red;height:100px;margin-top:10px} 
.left{float:left;width:20%;height:200px;background:#DDD} 
.right{float:right;width:30%;height:80px;background:#DDD} 
/*清除浮动代码*/ 
.clearfloat{clear:both} 
</style> 
<div class="div1"> 
<div class="left">Left</div> 
<div class="right">Right</div> 
<div class="clearfloat"></div> 
</div> 
<div class="div2"> 
div2 
</div> 
```
- **原理：**`添加一个空div，利用css提高的clear:both清除浮动，让父级div能自动获取到高度 `
- **优点：**``简单、代码少、浏览器支持好、不容易出现怪问题 ``
- **缺点：**`不少初学者不理解原理；如果页面浮动布局多，就要增加很多空div，让人感觉很不好`
- **建议：**`不推荐使用，但此方法是以前主要使用的一种清除浮动方法 `

### 3. 父级div定义 伪类:after 和 zoom 
```css
<style type="text/css"> 
.div1{background:#000080;border:1px solid red;} 
.div2{background:#800080;border:1px solid red;height:100px;margin-top:10px} 
.left{float:left;width:20%;height:200px;background:#DDD} 
.right{float:right;width:30%;height:80px;background:#DDD} 
/*清除浮动代码*/ 
.clearfloat:after{display:block;clear:both;content:"";visibility:hidden;height:0} 
.clearfloat{zoom:1} 
</style> 
<div class="div1 clearfloat"> 
<div class="left">Left</div> 
<div class="right">Right</div> 
</div> 
<div class="div2"> 
div2 
</div> 
```
- **原理：**`IE8以上和非IE浏览器才支持:after，原理和方法2有点类似，zoom(IE转有属性)可解决ie6,ie7浮动问题 `
- **优点：**`浏览器支持好、不容易出现怪问题（目前：大型网站都有使用，如：腾迅，网易，新浪等等`
- **缺点：**`代码多、不少初学者不理解原理，要两句代码结合使用才能让主流浏览器都支持。`
- **建议：**`推荐使用，建议定义公共类，以减少CSS代码。 `

### 4. 父级div定义 overflow:hidden 
```css
<style type="text/css"> 
.div1{background:#000080;border:1px solid red;/*解决代码*/width:98%;overflow:hidden} 
.div2{background:#800080;border:1px solid red;height:100px;margin-top:10px;width:98%} 
.left{float:left;width:20%;height:200px;background:#DDD} 
.right{float:right;width:30%;height:80px;background:#DDD} 
</style> 
<div class="div1"> 
<div class="left">Left</div> 
<div class="right">Right</div> 
</div> 
<div class="div2"> 
div2 
</div> 
```
- **原理：**`必须定义width或zoom:1，同时不能定义height，使用overflow:hidden时，浏览器会自动检查浮动区域的高度 `
- **优点：**`简单、代码少、浏览器支持好 `
- **缺点：**`不能和position配合使用，因为超出的尺寸的会被隐藏。` 
- **建议：**`只推荐没有使用position或对overflow:hidden理解比较深的朋友使用。`

### 5. 父级div定义 overflow:auto 
```css
<style type="text/css"> 
.div1{background:#000080;border:1px solid red;/*解决代码*/width:98%;overflow:auto} 
.div2{background:#800080;border:1px solid red;height:100px;margin-top:10px;width:98%} 
.left{float:left;width:20%;height:200px;background:#DDD} 
.right{float:right;width:30%;height:80px;background:#DDD} 
</style> 
<div class="div1"> 
<div class="left">Left</div> 
<div class="right">Right</div> 
</div> 
<div class="div2"> 
div2 
</div> 
```
- **原理：**`必须定义width或zoom:1，同时不能定义height，使用overflow:auto时，浏览器会自动检查浮动区域的高度 `
- **优点：**`简单、代码少、浏览器支持好 `
- **缺点：**`内部宽高超过父级div时，会出现滚动条。` 
- **建议：**`不推荐使用，如果你需要出现滚动条或者确保你的代码不会出现滚动条就使用吧。 `

### 6. 父级div 也一起浮动 
```css
<style type="text/css"> 
.div1{background:#000080;border:1px solid red;/*解决代码*/width:98%;margin-bottom:10px;float:left} 
.div2{background:#800080;border:1px solid red;height:100px;width:98%;/*解决代码*/clear:both} 
.left{float:left;width:20%;height:200px;background:#DDD} 
.right{float:right;width:30%;height:80px;background:#DDD} 
</style> 
<div class="div1"> 
<div class="left">Left</div> 
<div class="right">Right</div> 
</div> 
<div class="div2"> 
div2 
</div> 
```
- **原理：**`所有代码一起浮动，就变成了一个整体 ``
- **优点：**`没有优点 `
- **缺点：**`会产生新的浮动问题。 `
- **建议：**`不推荐使用，只作了解。`

### 7. 父级div定义 display:table 
```css
<style type="text/css"> 
.div1{background:#000080;border:1px solid red;/*解决代码*/width:98%;display:table;margin-bottom:10px;} 
.div2{background:#800080;border:1px solid red;height:100px;width:98%;} 
.left{float:left;width:20%;height:200px;background:#DDD} 
.right{float:right;width:30%;height:80px;background:#DDD} 
</style> 
<div class="div1"> 
<div class="left">Left</div> 
<div class="right">Right</div> 
</div> 
<div class="div2"> 
div2 
</div> 
```
- **原理：**`将div属性变成表格 `
- **优点：**`没有优点 `
- **缺点：**`会产生新的未知问题。 `
- **建议：**`不推荐使用，只作了解。 `

### 8. 结尾处加 br标签 clear:both 
```css
<style type="text/css"> 
.div1{background:#000080;border:1px solid red;margin-bottom:10px;zoom:1} 
.div2{background:#800080;border:1px solid red;height:100px} 
.left{float:left;width:20%;height:200px;background:#DDD} 
.right{float:right;width:30%;height:80px;background:#DDD} 
.clearfloat{clear:both} 
</style> 
<div class="div1"> 
<div class="left">Left</div> 
<div class="right">Right</div> 
<br class="clearfloat" /> 
</div> 
<div class="div2"> 
div2 
</div> 
```
- **原理：**`父级div定义zoom:1来解决IE浮动问题，结尾处加 br标签 clear:both `
- **建议：**`不推荐使用，只作了解。`



flex布局子视图中一个固定宽度另一个独占剩余宽度

```css
父视图: display:flex;
子视图1  width: xxxpx;
子视图2 flex:1;
```
flex居中显示文字
```html
<div style="display: flex;align-items: center;">
	<span>文字文字文字</span>
</div>
```