```bash

showMenu(){
echo "/**
 *     
 *   使用方法: npm_config 选择命令对应的数字回车即可  	
 *
 */"
	
echo "======================================"
echo "请选择需要执行的命令选项"
echo "1. 自定义registry"
echo "2. 全局切换淘宝源"
echo "3. 全局切换平安源"
echo "4. 全局切换npm官方默认源"
echo "5. 查看当前源配置"
echo "6. 查看npm当前配置"
echo "7. 退出当前命令行菜单"
echo "======================================"
	
read -p "输入选项编号：" number
case $number in 
    0)  
    ;;
    1) setCustomRegistry	
    ;;
        
    2) setTaoBaoSource
    ;;
    
    3) setPaicSource
    ;;

    4) setOfficialSource
    ;;
    
    5) watchNpmRegistry
    ;;
    6)
        watchNpmConfig
    ;;

    7)
        exit 0
    ;;
  esac	
}

setCustomRegistry(){
    read -p "输入镜像源地址: " source_url
    npm config set registry  $source_url
}

setTaoBaoSource(){
    npm config set registry  'https://registry.npm.taobao.org/'
}

setPaicSource(){
    npm config set registry http://maven.paic.com.cn/repository/npm
}

setOfficialSource(){
    npm config set registry https://registry.npmjs.org
}

#查看当前registry
watchNpmRegistry(){
    npm config get registry
}

watchNpmConfig(){
    npm config list 
}

showMenu
```