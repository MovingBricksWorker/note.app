```python
# easyGUI
import sys
from  easygui import *
# msgbox(msg='hello world!',title='我就是标题')
##############

# choices = ['喜欢','很喜欢','不喜欢','讨厌']
# reply =  choicebox("Do you like me ?",choices=choices)
#################
# msgbox('你厉害啊!',ok_button="真的嘛?",title="标题大头")

########
# if ccbox("想得到她嘛?",choices=["想","不想"],title="二选一,选一个吧!"):
#     msgbox("那你没得选咯!")
# else:
#     msgbox('真香!')
##############
# if ynbox("想去大南山嘛?",choices=["想","不想"],title="二选一,选一个吧!"):
#     msgbox("那你没得选咯!")
# else:
#     msgbox('真好玩!!')
##############
# value = buttonbox("三个按钮喜欢哪一个?",title="天选之子",choices=["牛逼","厉害","666"])
# print(value)
###########
# def func(box):
#             print(box)
#             sys.exit(0)
# buttonbox("三个按钮喜欢哪一个?",title="天选之子",choices=["牛逼","厉害","666"],callback=func)
########
# index =  indexbox("选择一个吧?",title="选择题",choices=["选","不选"])
# print(index)
##########
# boolValue = boolbox("我是一个弹窗嘛?",title="布尔弹窗",choices=['YES','NO'])
########
# index = multchoicebox("超多复选框?",title="可选可不选",choices=["第一","老二","三当家的","老四","五爷","小六子"])
# print(index)
#########
# content = enterbox(title="说出你的故事",msg= "说呀说呀",default="请清空后输入...")
# print(content)
# num = integerbox("请输入你想输入的数字","数字输入框(20~1000以内包含0不包含1000的整数)",lowerbound=20,upperbound=999)
# print(num)
##############
# fields = ["*手机号","*密码","邀请码","*邮箱","*紧急联系人"]
# default_values= ["","","10086","","你大爷"]
# value = multenterbox("多级输入框,打*的为必填项","多个输入框",fields=fields,values=default_values)
# print(value)

############
# pwd = passwordbox("请输入密码","密码框")
# print(pwd)
#########
# res =  multpasswordbox("请输入账号密码","账号和密码",fields=["账号","密码"],values=["",])
# print(res)
############
# text = """
# 从明天起，做一个幸福的人
# 喂马，劈柴，周游世界
# 从明天起，关心粮食和蔬菜
# 我有一所房子，面朝大海，春暖花开
# 从明天起，和每一个亲人通信
# 告诉他们我的幸福
# 那幸福的闪电告诉我的
# 我将告诉每一个人
# 给每一条河每一座山取一个温暖的名字
# 陌生人，我也为你祝福
# 愿你有一个灿烂的前程
# 愿你有情人终成眷属
# 愿你在尘世获得幸福
# 我只愿面朝大海，春暖花开
# """
# value = textbox("显示文本","文本面板",text=text)
# print(value)
###############
# 以等宽字体显示文本内容，相当于textbox(codebox=1)
# codebox("代码形式","标题而已","数据哈撒仅仅是卡开始看看卡死卡死卡卡卡卡是是卡卡卢卡申科卡卡卡卡死卡死卡死")
#####################
## 选择文件夹路径
# diropenbox(msg = '请选择文件夹：',title = '浏览文件路径')
###########
## 选择文件
# fileopenbox(msg = '请选择文件：',title = '浏览文件')
###########
## 保存文件  返回路径 写入文件
# res = filesavebox("保存文件", "文件", "demo.txt")
# print(res)
# with open(res,'w') as f:
#      f.write("66666666gggggggsssssssssssssoooooooo")

```