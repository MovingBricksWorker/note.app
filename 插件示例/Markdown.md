# 扩展的markdown语法

```markdown
!> 一段重要的内容，可以和其他 **Markdown** 语法混用。

?> 一段重要的内容，可以和其他 **Markdown** 语法混用。
```

!> 一段重要的内容，可以和其他 **Markdown** 语法混用。

?> 一段重要的内容，可以和其他 **Markdown** 语法混用。

**跳转本地页面而非跳转对应的markdown文件进行渲染**
```markdown
- [CSS动画](pages/css3demo.html ':ignore')
```
- [CSS动画](pages/css3demo.html ':ignore')

设置跳转链接的方式
```
[link](/demo ':target=_blank')
[link](/demo2 ':target=_self')
[link](/demo ':disabled')
```

GitHub任务列表
```
- [ ] foo
- bar
- [x] baz
- [] bam <~ not working
  - [ ] bim
  - [ ] lim
```
- [ ] foo
- bar
- [x] baz
- [ ] bam <~ not working
  - [ ] bim
  - [ ] lim


  图片处理
  
```markdown
![logo](https://docsify.js.org/_media/icon.svg ':size=WIDTHxHEIGHT')
![logo](https://docsify.js.org/_media/icon.svg ':size=50x100')
![logo](https://docsify.js.org/_media/icon.svg ':size=100')

<!-- 支持按百分比缩放 -->
![logo](https://docsify.js.org/_media/icon.svg ':size=10%')
  ```

设置样式选择器class和id
```md
![logo](https://docsify.js.org/_media/icon.svg ':class=someCssClass')
![logo](https://docsify.js.org/_media/icon.svg ':id=someCssId')
### 你好，世界！ :id=hello-world

```

html 标签中的 Markdown 混合使用
```md
<details>
<summary>自我评价（点击展开）</summary>

- Abc

- Abc

</details>

<div style='color: red'>

- listitem
- listitem
- listitem

</div>
```
<details>
<summary>自我评价（点击展开）</summary>

- Abc
- Abc

</details>

<div style='color: red'>

- listitem
- listitem
- listitem

</div>


文件嵌入

```md
[filename](../_404.md ':include')
```
[filename](../_404.md ':include')


### 图片处理
`img`标签🏷加上`data-no-zoom`这个属性就不会默认查看大图
```html
<img src="https://shadow.elemecdn.com/app/element/hamburger.9cf7b091-55e9-11e9-a976-7f4d0b07eef6.png" class="image" data-no-zoom>

```
<img src="https://shadow.elemecdn.com/app/element/hamburger.9cf7b091-55e9-11e9-a976-7f4d0b07eef6.png" class="image" data-no-zoom>

**不看大图**

![](../pages/assets/alfredappicon.png  ":no-zoom")



**要看大图**

![](../pages/assets/alfredappicon.png '图片')




> [!NOTE]
> An alert of type 'note' using global style 'callout'.


> [!NOTE|style:callout]
> 全局默认的是flat扁平风格 局部也可以设置`callout`风格的提示  就像当前这个

> [!TIP]
> An alert of type 'tip' using global style 'callout'.

> [!WARNING]
> An alert of type 'warning' using global style 'callout'.

> [!ATTENTION]
> An alert of type 'attention' using global style 'callout'.


> [!TIP|style:flat|label:My own heading|iconVisibility:hidden]
> An alert of type 'tip' using alert specific style 'flat' which overrides global style 'callout'.
> In addition, this alert uses an own heading and hides specific icon.