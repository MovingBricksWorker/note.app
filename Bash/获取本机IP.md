
```bash
ifconfig | sed -e '/.*inet /!d;s///;s/ .*//' | tail -n 1

```

###### 利用MacOS系统自带的`Python`简单实现`Webserver`

```bash
#! /bin/bash
#调用: webServer -p 8888

IP=$(ifconfig | sed -e '/.*inet /!d;s///;s/ .*//' | tail -n 1)
IP_PORT=8888
while getopts "p:" opt; do
  case $opt in
    p)
       IP_PORT=$OPTARG 
      ;;
    \?)
      IP_PORT=8888
      ;;
  esac
done

#先关闭指定的端口 避免占用导致开不成功~
kill -9 `lsof -t -i:$IP_PORT`

CurrentDir=`pwd`
echo "🚀 当前目录为:${CurrentDir},WebServer已开启"
IPs=$(ifconfig | sed -e '/.*inet /!d;s///;s/ .*//')
echo "🏡 访问地址如下: "
echo "http://localhost:${IP_PORT}"
for ip in ${IPs[@]}
do
echo "http://"$ip":${IP_PORT}"  
done
echo "🔥 欢迎使用~ 🔥"

#python2.x
# python -m SimpleHTTPServer $IP_PORT

#python3.x
python3 -m http.server $IP_PORT --bind ${IP}

```