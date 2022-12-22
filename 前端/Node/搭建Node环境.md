> [!ATTENTION] 参考包教不包会系列教程
> https://github.com/alsotang/node-lessons

安装nvm (node版本管理工具)
 https://github.com/creationix/nvm

```bash
$ curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.25.2/install.sh | bash
```
安装好之后
```bash
nvm #看看打印
```

安装指定版本
```bash
nvm install 14.16.1 #指定安装node版本
```

查看自己电脑已安装的所有node版本
```bash
nvm ls
```

切换指定版本
```bash
nvm use 14.16.1 
```

命令行交互
```bash
node
```

配置环境变量
`~/.profile`或者 `~/.bash_profile`中加入以下代码
```bash
export NVM_DIR="~/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" 
```

