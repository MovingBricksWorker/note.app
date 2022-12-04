*JavaScript 中的原型继承*

| JavaScript 原型编程基本规则                                  |
| :----------------------------------------------------------- |
| 1.  除基本数据类型,所有数据均为对象                          |
| 2.  要得到一个对象,不是通过实例化,而是找到一个对象作为它的原型 |
| 3.  对象会记得它的原型                                       |
| 4.  如果对象无法响应某个请求,它会把这个请求委托给它的原型    |



####   所有数据都是对象

```js
// 不能说JS中所有的数据都是对象，但可以说绝大多数是，因为他还包含基本数据类型
// JS 的本意是除了undefined外，一切都是对象；所以基本数据类型可以通过“包装类” 变成对象数据
// JavaSript 中的根对象是 Object.prototype 对象
// Object.prototype 是一个空对象，我们在JS中遇到的每个对象，都是从这个对象中克隆出来的
// Object.prototype 就是他们的原型
var obj1 = new Object()
var obj2 = {}
// Object.getPrototypeOf 查看对象原型
console.log(Object.getPrototypeOf(obj1) === Object.prototype)   // true
console.log(Object.getPrototypeOf(obj2) === Object.prototype)   // true
```



#### 要得到一个对象，不是通过实例化，而是找到一个对象作为他的原型

```js
// JavaScript 克隆对象并不需要显示的clone方法，而是调用 var obj = new Object(), var obj = {}
// 这样引擎内部会自动从Object.prototype 上面克隆一个对象
function Person(name) {
    this.name = name
}
Person.prototype.getName = function() {
    return this.name
}

var person = new Person("Jobs")
console.log(person.name)                    // Jobs
console.log(person.getName())               // Jobs
console.log(Object.getPrototypeOf(person) === Person.prototype) // true
console.log(Object.getPrototypeOf(person) === Object.prototype) // false
```

#### 对象会记住他的原型

#### 如果对象无法响应某个请求，他会把这个请求委托给他的原型

```js
// 对象会记住他的原型
// 如果对象无法响应某个请求，他会把这个请求委托给他的原型
var obj = {name: 'Jobs'}
var A = function(){}
A.prototype = obj

var a = new A()
console.log(a.name)     // 遍历 a中所有的属性，并没有name属性，由于a.__proto__ 指向 A.protocol ,而A.protocol 被设置为obj，所以我们在obj中查找name
console.log(Object.getPrototypeOf(a.__proto__) === Object.getPrototypeOf(obj))

var obj = {name: 'Jobs'}
var A = function(){}
A.prototype = obj

// 函数.prototype
// 对象.__proto__
var a = new A()
console.log(obj.__proto__)    
console.log(A.prototype)            // {name: 'Jobs'}
console.log(a.__proto__)            // {name: 'Jobs'}
console.log(Object.getPrototypeOf(a.__proto__) === Object.getPrototypeOf(obj))
console.log(a.__proto__.__proto__ === Object.prototype)  // true
console.log(obj.__proto__ === Object.prototype)          // true
console.log(Object.prototype)

/**
 * Object
 * /\
 * ||
 * ||
 * obj = {name: 'Job'}
 * /\
 * ||
 * ||
 * A
 * 
 * Object.prototype
 * /\
 * ||
 * ||
 * obj.__proto__
 * /\               /\
 * ||               ||    
 * ||               ||
 * A.prototype  <- a.__proto__
 * 
 */

var obj = { name: 'sven' };

var A = function(){}; 
A.prototype = obj;

var a = new A(); 
console.log( a.name );
/**
 * 1. 首先查找对象a中所有的属性，但没找到 name这个属性
 * 2. 查找name属性这个请求被委托给对象a的构造器的原型, 它被 a.__proto__ 记录着并指向A.prototype, 而A.prototype 设置为对象obj
 * 3. 从对象obj中找到name属性，返回他的值
 */

var A = function() {}
A.prototype = {name: "seven"}

var B = function() {}
B.prototype = new A()

var b = new B()
console.log(b.name)
```

