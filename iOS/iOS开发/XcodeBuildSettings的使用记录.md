### Generate Debug Symbols
这个选项是生成调试符号(Symbols),一般可以在`Release`时关掉会减少包体积大小,但是`Debug`一定要打开,不然打断点会失灵

?> Generate Debug Symbols的意思是生成调试符号，当这个选项设置为YES时，每个源文件在编译成.o文件时，编译参数多了-g和-gmodule，意思是generate complete debug info，所以产生的.o文件会大，从而最终生成的可执行文件也就会变大。\
注意Generate Debug Symbols设置为NO时，在Xcode中设置的断点不会中断，即不能断点调试。且最后不能生成dSYM文件，即使Debug Information Format设置了，也不能生成，因为首先要有调试信息然后才能生成dSYM文件，而设置为NO，意味着不产生调试信息，所以也就没办法生成dSYM文件。所以建议不要设置。

### Deployment Postprocessing

`Debug`模式下设置`NO`, `Release`下设为`YES`, 裁剪链接和调试符号

?> `Deployment Postprocessing` 是 `Strip` 配置的总开关，只有这个设置为`YES`之后，下面的`Strip  Linked Product`、`Strip Debug Symbols During Copy`的设置才会生效。


#### Strip Linked Product
`Debug`模式下设置`NO`, `Release`下设为`YES`,

!> 对最后生成的二进制文件进行`strip`，去除不必要的符号信息，`Release`下可以为`YES`。注意，如果`Deployment Postprocessing`不打开，该选项没有作用。去除了符号信息之后需要使用dSYM来进行符号化，所以需要将 `Debug Information Format` 修改为`DWARF with dSYM file`（`Release`下），如果在`Debug`下设置为`DWARF with dSYM file`那么在崩溃时将无法看到堆栈信息,主要生成dsym信息用来看崩溃日志的,如果直接输出到文件就会影响调试,所以还是在`Release`做这件事,通过bugly等一些工具获取堆栈日志回溯崩溃等异常

#### Strip Debug Symbols During Copy
`Debug`模式下设置`NO`, `Release`下设为`YES`

?> 文件拷贝编译阶段是否进行`strip`，设置为`YES`之后，会把拷贝进项目包的三方库、资源或者`Extension`的`Debug Symbol`去除。同样，如果`Deployment Postprocessing`不打开，该选项没有作用


#### Symbols Hidden by Default
`Debug`模式下设置为`NO`, `Release`下设置为`YES`
`Symbols Hidden by Default`会把所有符号都定义成`private extern`，移除符号信息。


### Make Strings Read-Only
设置为`YES`
`Make Strings Read-Only`(`GCC_REUSE_STRINGS`), `Reuse string literals` 就是复用字符串字面量，提到复用，顾名思义就是减少生成不必要的，也是优化的一种形式。

### Dead Code Stripping
消除死代码,就是无用代码,主要是参与编译的代码, 针对`C/C++/Swift` 等静态语言编译器会在 `link` 的时候移除未使用的代码，对于`OC`等动态语言是无效的。