##### pod管理的sdk打包 

新建了一个Aggregate Target  `PackageScript`

`RunScript`如下:

```bash
sh xcode_build_framework.sh "armv7,arm64"
```

`pack.sh`如下:

```bash
#因为需要armv7  所以使用放在桌面上的低版本Xcode
~/Desktop/Xcode.app/Contents/Developer/usr/bin/xcodebuild -configuration Release -scheme PackageScript -sdk iphoneos  -workspace "MyAPM.xcworkspace";
```

编译脚本`xcode_build_framework.sh`如下: 

```bash
set -e

##SDK的名字
SDK_NAME='MyAPM'
#SDK产出目录
INSTALL_DIR=${SRCROOT}/Products

#清空编译缓存
rm -rf ${BUILD_DIR}

#输入指定架构 "arm64,armv7,..." 用逗号隔开即可
select_arch=${1}
# 获取真机的架构
iphoneos_archs=(${select_arch//,/ })
echo "本次打包的CPU架构为: "${iphoneos_archs[*]}

#执行真机编译指令 采用的是桌面上的xcode12版本 需要支持armv7  Xcode14苹果移除了armv7的支持
#xcodebuild -configuration 'Release' -workspace "${PROJECT_NAME}.xcworkspace" -scheme "${SDK_NAME}" -sdk iphoneos  build ARCHS="${iphoneos_archs[*]}" 
~/Desktop/Xcode.app/Contents/Developer/usr/bin/xcodebuild -configuration 'Release' -workspace "${SDK_NAME}.xcworkspace" -scheme "${SDK_NAME}" -sdk iphoneos  build ARCHS="${iphoneos_archs[*]}" SYMROOT="${INSTALL_DIR}" -UseModernBuildSystem=NO
#调整目录
rm -rf ${INSTALL_DIR}/Release-iphoneos/${SDK_NAME}.framework/_CodeSignature
cp -R  ${INSTALL_DIR}/Release-iphoneos/${SDK_NAME}.framework  ${SRCROOT}/
rm -rf ${INSTALL_DIR}

#编译完自动替换demo里的SDK并打开demo工程
cp -Rf  ${SRCROOT}/${SDK_NAME}.framework/  ../MyAPMDemo/MyAPMDemo/SDKs/MyAPM.framework/ 
open ../MyAPMDemo/*.xcworkspace

echo "脚本跑🏃完了 [ DONE ]"
exit 0;

```



#####  仅使用project管理的sdk

新建了一个Aggregate Target `PackScript`     添加RunScript如下: 

```bash
sh xcode_build_framework.sh "armv7,arm64,x86_64" 
```

`pack.sh` 如下:

```bash
cd ~/Desktop/hotfix_ios/OCRunner; /Users/mac/Desktop/Xcode.app/Contents/Developer/usr/bin/xcodebuild -configuration Release -scheme PackScript -sdk iphoneos  -project OCRunner.xcodeproj;
```



编译脚本`xcode_build_framework.sh`如下:

```bash
set -e
#编译Debug还是Release
ConfigEnv="Release"

##SDK的名字
SDK_NAME='OCRunner'
#SDK产出目录
INSTALL_DIR=${SRCROOT}/${SDK_NAME}.framework

#清空编译缓存
rm -rf ${BUILD_DIR}

#输入指定架构 "arm64,armv7,..." 用逗号隔开即可
select_arch=${1}
# 默认已选择armv7和arm64 点取消才会走这里
if [[ $select_arch = false ]] ;
then
    echo "未选择架构,已取消本次编译."
    exit 0;
fi

simulator_archs=()
if [[ $select_arch =~ "i386" ]] ;
then
    simulator_archs+=("i386")
fi

if [[ $select_arch =~ "x86_64" ]] ;
then
    simulator_archs+=("x86_64")
fi

echo "模拟器架构为: "${simulator_archs[*]}

#模拟器架构个数,如果个数为0,则不需要模拟器参与编译了
simulator_archs_length=${#simulator_archs[*]}
if [[ $simulator_archs_length == 0 ]] ;
then
    echo "模拟器架构数为0,模拟器无需参与编译"
else
    # 剔除模拟器架构
    select_arch=${select_arch//i386/ }
    select_arch=${select_arch//x86_64/ }
fi

# 获取真机的架构
iphoneos_archs=(${select_arch//,/ })
echo "真机架构为: "${iphoneos_archs[*]}

if [[ $simulator_archs_length > 0 ]] ;
then
# 执行模拟器编译指令
xcodebuild -configuration ${ConfigEnv} -target "${SDK_NAME}" -sdk iphonesimulator build ARCHS="${simulator_archs[*]}"
fi

#执行真机编译指令
xcodebuild -configuration ${ConfigEnv} -target "${SDK_NAME}" -sdk iphoneos  build ARCHS="${iphoneos_archs[*]}"

#真机目录
DEVICE_DIR="build"/${ConfigEnv}-iphoneos/${SDK_NAME}.framework
#模拟器目录
SIMULATOR_DIR="build"/${ConfigEnv}-iphonesimulator/${SDK_NAME}.framework

#清除旧的安装目录
if [ -d "${INSTALL_DIR}" ]
then
rm -rf "${INSTALL_DIR}"
fi
#创建新的安装目录
mkdir -p "${INSTALL_DIR}"
#拷贝编译产物到安装目录
cp -R "${DEVICE_DIR}/" "${INSTALL_DIR}/"

# 有模拟器编译才需要合并
if [[ $simulator_archs_length > 0 ]] ;
then
#合并真机和模拟器的编译产物
lipo -create "${DEVICE_DIR}/${SDK_NAME}" "${SIMULATOR_DIR}/${SDK_NAME}" -output "${INSTALL_DIR}/${SDK_NAME}"
fi

rm -rf "${INSTALL_DIR}/_CodeSignature"
rm -rf "${SRCROOT}/build"

cp -Rf  ${INSTALL_DIR}/  ../OCRunnerDemo/OCRunnerDemo/${SDK_NAME}.framework/ 

echo "脚本跑🏃完了 [ DONE ]"
exit 0;
```


剔除项目中多余架构的脚本,编译加一个RunScript即可
```bash
#!/bin/sh

# Strip invalid architectures

strip_invalid_archs() {
binary="$1"
echo "current binary ${binary}"
# Get architectures for current file
archs="$(lipo -info "$binary" | rev | cut -d ':' -f1 | rev)"
stripped=""
for arch in $archs; do
if ! [[ "${ARCHS}" == *"$arch"* ]]; then
if [ -f "$binary" ]; then
# Strip non-valid architectures in-place
lipo -remove "$arch" -output "$binary" "$binary" || exit 1
stripped="$stripped $arch"
fi
fi
done
if [[ "$stripped" ]]; then
echo "Stripped $binary of architectures:$stripped"
fi
}

APP_PATH="${TARGET_BUILD_DIR}/${WRAPPER_NAME}"

# This script loops through the frameworks embedded in the application and
# removes unused architectures.
find "$APP_PATH" -name '*.framework' -type d | while read -r FRAMEWORK
do
FRAMEWORK_EXECUTABLE_NAME=$(defaults read "$FRAMEWORK/Info.plist" CFBundleExecutable)
FRAMEWORK_EXECUTABLE_PATH="$FRAMEWORK/$FRAMEWORK_EXECUTABLE_NAME"
echo "Executable is $FRAMEWORK_EXECUTABLE_PATH"

strip_invalid_archs "$FRAMEWORK_EXECUTABLE_PATH"
done

```