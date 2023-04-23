下载编译对应版本的`protoc`命令行工具  https://github.com/protocolbuffers/protobuf

步骤如下: 

```bash
./autogen.sh
./configure
make
make check
sudo make install
protoc --version
which protoc
#打印 /usr/local/bin/protoc 说明编译安装成功~ brew安装是挺方便 但是要指定版本还是得手动挡

```

按步骤自己编译是没错,可以知道是怎么来的,但是人家早就提供好了release版本的tag包直接找一个osx对应版本下载即可 解压把bin目录下的可执行文件放到本地的/usr/local/bin下即可


贴一个脚本记录一下
```bash
#建立临时目录
time=$(date +"%s")
tmpPath="/tmp/"$time
echo $tmpPath
mkdir -p  $tmpPath
#拉取代码 使用ssh 无需输入账号密码 就这一点好处
git clone git@e.coding.net:jutongtech/akyuyin/aklive_protocol.git  $tmpPath
#进入目录
cd $tmpPath
ls 
mkdir objc_out

cd proto

#修复目录不正确的问题 (后端瞎搞 目录移来移去的)
cp -Rf ./_client_pb ./client
cp -Rf ../only_client/* ./client/
mv ./mods/misc/mars.ext.proto1 ./mods/misc/mars.ext.proto

#定义一个数组 按需拉取 全在proto目录下
pbs=()
pbs[0]="pb/activity.ext.proto" 
pbs[1]="pb/activity_common.proto" 
pbs[2]="pb/assets.ext.proto" 
pbs[3]="pb/bill.ext.proto"  
pbs[4]="pb/nobility.ext.proto" 
pbs[5]="pb/common.ext.proto" 
pbs[6]="pb/friend.ext.proto" 
pbs[7]="pb/gift.ext.proto" 
pbs[8]="pb/index.ext.proto" 
pbs[9]="pb/red_envelope.ext.proto" 
pbs[10]="pb/room.ext.proto" 
pbs[11]="pb/room_pk.ext.proto" 
pbs[12]="pb/system.ext.proto" 
pbs[13]="pb/user.ext.proto"
pbs[14]="pb/user_status.ext.proto" 
pbs[15]="pb/play.ext.proto" 
pbs[16]="pb/blinddate.ext.proto" 
pbs[17]="pb/game.ext.proto" 
pbs[18]="pb/rocket.ext.proto" 
pbs[19]="pb/crack_egg.ext.proto" 
pbs[20]="pb/store.ext.proto" 
pbs[21]="plugin_pb/phome.ext.proto" 
pbs[22]="plugin_pb/community.ext.proto" 
pbs[23]="plugin_pb/plugin.ext.proto" 
pbs[24]="uauth_pb/uauth_common.proto" 
pbs[25]="uauth_pb/uauth.ext.proto" 
pbs[26]="ures_pb/ures.ext.proto" 
pbs[27]="ures_pb/ures.int.proto" 
pbs[28]="mods/misc/mars.ext.proto" 
pbs[29]="upgrade_pb/upgrade.ext.proto" 
pbs[30]="client/flutter.proto" 
pbs[31]="client/local_customize.ext.proto"

#遍历生成OC文件
for pb in ${pbs[*]}; do
	protoc -I=. --objc_out=../objc_out  $pb
done

#拷贝产物
cd .. 
rm -rf ~/Desktop/alive-ios/PBPods/LocalPBOCFiles/*
mv -f ./objc_out/*  ~/Desktop/alive-ios/PBPods/LocalPBOCFiles/
cd ~/Desktop/alive-ios
#删除临时文件
dateStr=`date`

podspec=$(cat<<EOF 
Pod::Spec.new do |s|
  s.name             = 'LocalPBOCFiles'
  s.version          = '1.0.0'
  s.summary          = 'PB文件本地pod管理'

  s.description      = <<-DESC
   执行脚本 sh update_pb.sh 自动拉取远程的pb文件, 本地pod管理, 更新时间为${dateStr}
                       DESC

  s.homepage         = 'https://github.com/xxx/xxx'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xxx' => 'xxxx' }
  s.source           = { :file => './LocalPBOCFiles', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.source_files = 'LocalPBOCFiles/**/*.{h,m}'
  s.dependency  "Protobuf","~>3.6.1"
end
EOF
) 
#生成podspec文件
echo "$podspec" > ./PBPods/LocalPBOCFiles.podspec

pod install
echo "PB一条龙🐲已搞定~ PodFile添加  pod 'LocalPBOCFiles',:path => './PBPods' 即可使用"

```

进阶版本

1. shell遍历目录

```bash
#!/bin/bash
function getdir(){
    for element in `ls $1`
    do  
        dir_or_file=$1"/"$element
        if [ -d $dir_or_file ]
        then 
            getdir $dir_or_file
        else
            #打印当前文件路径 然后过滤出pb文件类型
            pb=$(echo $dir_or_file | grep -e ".proto")
            #添加到数组里 截掉 proto/ 第一段父级路径名
            pbs=(${pbs[@]} ${pb#*/})
        fi  
    done
}
pbs=()
root_dir="proto"
getdir $root_dir
#打印数组长度
echo "PB文件数量为: "${#pbs[@]} 

```

2. 优化后的脚本如下: 


```bash
#! /bin/sh
rm -rf protoOC
mkdir protoOC

#建立临时目录
time=$(date +"%s")
tmpPath="/tmp/"$time
echo $tmpPath
mkdir -p  $tmpPath
#拉取代码 使用ssh 无需输入账号密码 
git clone -b release_ready git@e.coding.net:jutongtech/akyuyin/aklive_protocol.git  $tmpPath
#进入目录
cd $tmpPath
ls 
mkdir objc_out
cd objc_out
mkdir plugin_pb
mkdir pb
mkdir client
mkdir uauth_pb
cd ..

cd proto

cp -Rf plugin_pb/community.ext.proto    ../objc_out/plugin_pb/community.ext.proto
cp -Rf plugin_pb/phome.ext.proto    ../objc_out/plugin_pb/phome.ext.proto
cp -Rf plugin_pb/plugin.ext.proto    ../objc_out/plugin_pb/plugin.ext.proto

cp -Rf pb/crack_egg.ext.proto    ../objc_out/pb/crack_egg.ext.proto
cp -Rf pb/store.ext.proto    ../objc_out/pb/store.ext.proto

cp -Rf ../only_client/base_dynconfig.ext.proto   ../objc_out/client/base_dynconfig.ext.proto
cp -Rf ../only_client/local_customize.ext.proto   ../objc_out/client/local_customize.ext.proto


cp -Rf ../only_client/bridge.ext.proto   ../objc_out/client/bridge.ext.proto
cp -Rf _client_pb/common.proto   ../objc_out/client/common.proto
cp -Rf ../only_client/logic.proto   ../objc_out/client/logic.proto


cp -Rf ../only_client/rpcMessgage.ext.proto   ../objc_out/client/rpcMessgage.ext.proto
cp -Rf _goim_pb/lib_mars.ext.proto   ../objc_out/pb/mars.ext.proto
cp -Rf uauth_pb/uauth_common.proto   ../objc_out/uauth_pb/uauth_common.proto

cp -Rf uauth_pb/uauth.ext.proto   ../objc_out/uauth_pb/uauth.ext.proto

cp -Rf pb/activity.ext.proto   ../objc_out/pb/activity.ext.proto
cp -Rf pb/activity_common.proto   ../objc_out/pb/activity_common.proto
cp -Rf pb/assets.ext.proto   ../objc_out/pb/assets.ext.proto
cp -Rf pb/bill.ext.proto   ../objc_out/pb/bill.ext.proto
cp -Rf pb/blinddate.ext.proto   ../objc_out/pb/blinddate.ext.proto
cp -Rf pb/nobility.ext.proto   ../objc_out/pb/nobility.ext.proto
cp -Rf pb/common.ext.proto   ../objc_out/pb/common.ext.proto
cp -Rf pb/friend.ext.proto   ../objc_out/pb/friend.ext.proto
cp -Rf pb/gift.ext.proto   ../objc_out/pb/gift.ext.proto
cp -Rf pb/index.ext.proto   ../objc_out/pb/index.ext.proto
cp -Rf pb/play.ext.proto   ../objc_out/pb/play.ext.proto
cp -Rf pb/red_envelope.ext.proto   ../objc_out/pb/red_envelope.ext.proto
cp -Rf pb/room.ext.proto   ../objc_out/pb/room.ext.proto
cp -Rf pb/system.ext.proto   ../objc_out/pb/system.ext.proto
cp -Rf pb/user.ext.proto   ../objc_out/pb/user.ext.proto
cp -Rf pb/user_status.ext.proto   ../objc_out/pb/user_status.ext.proto
cp -Rf pb/room_pk.ext.proto   ../objc_out/pb/room_pk.ext.proto
cp -Rf pb/reporter.ext.proto  ../objc_out/pb/reporter.ext.proto

cp -Rf upgrade_pb/upgrade.ext.proto   ../objc_out/client/upgrade.ext.proto

cp -Rf pb/game.ext.proto   ../objc_out/pb/game.ext.proto
cp -Rf pb/rocket.ext.proto   ../objc_out/pb/rocket.ext.proto
cp -Rf pb/rocket.int.proto   ../objc_out/pb/rocket.int.proto
cp -Rf ../only_client/flutter.proto   ../objc_out/client/flutter.proto

cd .. 
mkdir protoOC
#把pb文件都转移到objc_out目录下 然后遍历objc_out目录下的所有.proto文件
function getdir(){
    for element in `ls $1`
    do  
        dir_or_file=$1"/"$element
        if [ -d $dir_or_file ]
        then 
            getdir $dir_or_file
        else
            pb=$(echo $dir_or_file | grep -e ".proto")
            pbs=(${pbs[@]} ${pb#*/})
        fi  
    done
}

pbs=()
root_dir="objc_out"
getdir $root_dir
echo "PB文件数量为: "${#pbs[@]} 
cd objc_out

#遍历生成OC文件 存放到protoOC目录下 生成之后将项目里的替换
for pbFile in ${pbs[*]}; do
   protoc -I=. --objc_out=../protoOC  $pbFile
done

# #移除子目录或者文件
# rm -rf ~/Desktop/alive-ios/aklive/protoOC/*
# #替换项目里的文件
# mv  -f ../protoOC/*  ~/Desktop/alive-ios/aklive/protoOC
# 输出看看先
mv  -f ../protoOC  ~/Desktop/alive-ios/
rm -rf $tmpPath

echo "\033[1;32m 拉取完成 [DONE]\033[m"

```