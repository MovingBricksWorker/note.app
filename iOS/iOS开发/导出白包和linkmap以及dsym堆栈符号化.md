!> https://blog.csdn.net/wm9028/article/details/50462320/

Write Link Map File 设置为YES

Path to Link Map File  =>  设置linkmap文件路径



导出dsym和ipa

```bash
app_dir="${BUILD_ROOT}/${CONFIGURATION}-iphoneos"
cd $app_dir

AppName=${EXECUTABLE_NAME}
AppFile=./${AppName}.app
mkdir -p Payload
cp -Rf ${AppFile} ./Payload/
zip -qryX ./$AppName.ipa  ./Payload
rm -rf Payload
cp -Rf $app_dir/$AppName.ipa  ~/Desktop/
cp -Rf $app_dir/$AppName.app.dSYM ~/Desktop/
open ~/Desktop

```



符号化

```objective-c
    0   CoreFoundation                      0x00000001c7fdde94 5CDC5D9A-E506-3740-B64E-BB30867B4F1B + 40596
	1   libobjc.A.dylib                     0x00000001c13138d8 objc_exception_throw + 60
	2   CoreFoundation                      0x00000001c80efb78 5CDC5D9A-E506-3740-B64E-BB30867B4F1B + 1162104
	3   xxx-Demo                    0x00000001004fe688 xxx-Demo + 108168
	4   UIKitCore                           0x00000001ca393514 179501B6-0FC2-344A-B969-B4E3961EBE10 + 2106644
	5   UIKitCore                           0x00000001ca28d6c4 179501B6-0FC2-344A-B969-B4E3961EBE10 + 1033924
	6   UIKitCore                           0x00000001ca28cc84 179501B6-0FC2-344A-B969-B4E3961EBE10 + 1031300
	7   UIKitCore                           0x00000001ca28bf44 179501B6-0FC2-344A-B969-B4E3961EBE10 + 1027908
	8   UIKitCore                           0x00000001ca28b600 179501B6-0FC2-344A-B969-B4E3961EBE10 + 1025536
	9   UIKitCore                           0x00000001ca2d33e4 179501B6-0FC2-344A-B969-B4E3961EBE10 + 1319908
	10  UIKitCore                           0x00000001ca5dc160 179501B6-0FC2-344A-B969-B4E3961EBE10 + 4501856
	11  CoreFoundation                      0x00000001c80a9f54 5CDC5D9A-E506-3740-B64E-BB30867B4F1B + 876372
	12  CoreFoundation                      0x00000001c80b632c 5CDC5D9A-E506-3740-B64E-BB30867B4F1B + 926508
	13  CoreFoundation                      0x00000001c803a210 5CDC5D9A-E506-3740-B64E-BB30867B4F1B + 418320
	14  CoreFoundation                      0x00000001c804fba8 5CDC5D9A-E506-3740-B64E-BB30867B4F1B + 506792
	15  CoreFoundation                      0x00000001c8054ed4 CFRunLoopRunSpecific + 612
	16  GraphicsServices                    0x0000000201356368 GSEventRunModal + 164
	17  UIKitCore                           0x00000001ca5333d0 179501B6-0FC2-344A-B969-B4E3961EBE10 + 3810256
	18  UIKitCore                           0x00000001ca533034 UIApplicationMain + 340
	19  xxx-Demo                    0x00000001004fe784 xxx-Demo + 108420
	20  dyld                                0x00000001e66bc960 CB3FF411-4762-34D2-86A4-ECA13F9FB6C3 + 88416


	//分析这一条堆栈信息
	3   xxx-Demo                    0x00000001004fe688 xxx-Demo + 108168

//命令行  -l是基地址 -i 是加上偏移量之后的地址 0x00000001004fe688 + 108168 = 0x100518d10
 xcrun atos -o xxx.app.dSYM/Contents/Resources/DWARF/xxx -arch arm64 -l 0x00000001004fe688 -i 0x100518d10
 
-[ViewController touchesBegan:withEvent:] (in xxx-Demo) (ViewController.m:79)
```




