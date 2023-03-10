需要安装`py2app`

```python
pip3 install  py2app
py2applet --make-setup  xxx.py #需要指定python3环境变量 不然得全路径
#例如: ~/Library/Python/3.9/bin/py2applet  --make-setup  xxx.py 
#可以编辑 setup.py 不用每次调用 py2applet --make-setup xxx.py 生成
python3 setup.py py2app  #执行该命令打包
```
我试了`tk` 和 `qt5`
奈何tk不支持新的Mac系统,好像需要升级tk
`qt5`随随便便就100多MB,如果开发轻量应用还是不太建议用qt5,或许是我打包的方式不对或者有什么其他的姿势~ 还有待学习







