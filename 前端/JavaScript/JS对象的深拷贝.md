使用 JSON.parse(JSON.stringify(xxx)) 有一定的弊端,貌似会丢数据
参考文章 [千万不要用JSON.stringify()去实现深拷贝！有巨坑！！ - 掘金](https://juejin.cn/post/7113829141392130078)
> [!ATTENTION]
> 1. 时间类型会被变成字符串类型数据
> 2. 当对象中有undefined类型或function类型的数据时 --- undefined和function会直接丢失
> 3. 当对象中有NaN、Infinity和-Infinity这三种值的时候 --- 会变成null
> 4. 当对象循环引用的时候 --会报错

[javascript高级篇之实现深拷贝的四种方式 - 掘金](https://juejin.cn/post/7109843641677398053)

正确✅写法应该是如此这般,妙用递归~
```js
function deepCopy(obj) {
  if (typeof obj !== 'object') return obj
  const o = { ...obj }
  Object.keys(o).forEach((key) => {
    const value = o[key]
    if (Array.isArray(value)) {
      o[key] = value.map((item) => {
        return deepCopy(item)
      })
    } else if (
      Object.prototype.toString.call(value).slice(8, -1) === 'Object'
    ) {
      o[key] = deepCopy(value)
    }
  })
  return o
}

const a = { a: { b: null }, b: [{ a: 1 }], c: function () {} }
const b = deepCopy(a)
```

或者
```js

//函数拷贝
const copyObj = (obj = {}) => {
        //变量先置空
        let newobj = null;  

        //判断是否需要继续进行递归
        if (typeof (obj) == 'object' && obj !== null) {
            newobj = obj instanceof Array ? [] : {};
            //进行下一层递归克隆
            for (var i in obj) {
                newobj[i] = copyObj(obj[i])
            }
            //如果不是对象直接赋值
        } else newobj = obj;
        
     return newobj;    
}

```