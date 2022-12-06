### struct实例

```rust
#[derive(Debug)]
struct Rectangle {
    width: u32,
    length: u32,
}

fn main() {
    let rect = Rectangle {
        width: 30,
        length: 50,
    };
    println!("{}", area(&rect));
    // 打印struct需要定义struct前添加 #[derive(Debug)] 注解
    //普通输出
    println!("{:?}", rect);
    //格式化输出
    println!("{:#?}", rect);
}

fn area(rect: &Rectangle) -> u32 {
    rect.width * rect.length
}
```

```rust
#[derive(Debug)]
struct Rectangle {
    width: u32,
    length: u32,
}

impl Rectangle {
    //struct实例方法 默认会把&self作为第一个参数
    fn area(&self) -> u32 {
        self.width * self.length
    }
    fn can_hold(&self, other: &Rectangle) -> bool {
        self.width > other.width && self.length > other.length
    }
    //关联方法  Rectangle::square(size) 
    fn square(size: u32) -> Rectangle {
        Rectangle {
            width: size,
            length: size,
        }
    }
}

fn main() {
    let s = Rectangle::square(20);
    println!("{:#?}",s);
    let rect = Rectangle {
        width: 30,
        length: 50,
    };
    let width = 10;
    let length = 20;
    let other = Rectangle { width, length };
    let can_hold = rect.can_hold(&other);
    println!("{}", can_hold);
    println!("{}", rect.area());
}
```
