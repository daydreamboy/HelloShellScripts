# GNU M4

[TOC]

## 1、介绍M4

GNU M4是Unix上的宏处理器，它提供内置函数，用于包含文件、运行shell命令以及算术运算等 ，而且支持用户定义的宏。

官方文档描述[^1]，如下

> GNU M4 is an implementation of the traditional Unix macro processor. It is mostly SVR4 compatible although it has some extensions (for example, handling more than 9 positional parameters to macros). GNU M4 also has built-in functions for including files, running shell commands, doing arithmetic, etc.
>
> GNU M4 is a macro processor in the sense that it copies its input to the output expanding macros as it goes. Macros are either builtin or user-defined and can take any number of arguments. Besides just doing macro expansion, m4 has builtin functions for including named files, running UNIX commands, doing integer arithmetic, manipulating text in various ways, recursion etc... m4 can be used either as a front-end to a compiler or as a macro processor in its own right.



### (1) m4命令

在MacOS上，默认带m4命令

```shell
$ m4 --version
GNU M4 1.4.6
Copyright (C) 2006 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

Written by Rene' Seindal.
```

m4命令的格式，如下

```shell
$ m4 [OPTION]... [FILE]
```



#### a. `-e`选项

m4命令支持交互式输入，使用`-e`选项，进入交互式模式。

说明

> 使用Ctrl+C可以退出交互式模式。



#### b. `-D`选项

使用`-D`选项，用于执行m4命令时，定义预处理宏。举个例子，如下

```shell
$ cat option_D.m4 
bar
$ m4 -Dbar=hello option_D.m4
hello
```

GNU文档给示例[^3]中，GNU版本的m4命令支持多个文件，如下

```shell
$ cat foo
bar
$ m4 -Dbar=hello foo -Dbar=world foo
⇒hello
⇒world
```

在MacOS上，m4命令并不支持多个文件。

实际上，MacOS上m4命令使用的Xcode提供工具链，位置如下

```shell
$ /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/m4
```



## 2、M4语法约定

### (1) Macro name

M4定义宏名字，按照下面规则[^5]

* 名字包含字母、数字以及下划线`_`
* 名字第一个字符不能是数字
* 名字区分大小写字母

举个有效命令的例子，如下

```
‘foo’, ‘_tmp’, and ‘name01’
```



m4命令会将文件的内容，按照最长匹配规则来匹配宏，并进行宏替换。

举个例子，如下

```shell
$ cat greedy_match_macro.m4 
bar2
$ m4 -Dbar=hello -Dbar2=world greedy_match_macro.m4 
world
```

这里同时定义了宏bar和bar2，但是按照最长匹配原则，宏替换的是bar2

> 示例文件，见greedy_match_macro.m4 



### (2) Quoted String

Quoted String(引号字符串)，使用一组<code>`</code>和<code>'</code>来组成一个引号字符串[^6]，如下

```
`quoted string'
```



如果引号字符串，没有包含任何字符，则宏展开是一个空字符串

```shell
$ cat quoted_string_empty_string.m4
`'
$ m4 quoted_string_empty_string.m4 

```



引号字符串里面的字符串，是不会被宏替换的。举个例子，如下

```shell
$ cat quoted_string.m4
`bar'
$ m4 -Dbar=hello quoted_string.m4
bar
```



如果宏替换后要显示``quoted string'`这样格式，可以double一下<code>`</code>和<code>'</code>。举个例子，如下

```shell
$ cat quoted_string_double_quotes.m4 
``bar''
$ m4 -Dbar=hello quoted_string_double_quotes.m4 
`bar'
```



### (3) Comment

M4的注释，以`#`开头和换行符结束[^7]。

注意

> 注释不能嵌套

举个例子，如下

```shell
$ cat comment_example.m4 
`quoted text' # `commented text'
`quoted text' # commented text
$ m4 comment_example.m4 
quoted text # `commented text'
quoted text # commented text
```



### (4) Macro expand

M4的宏展开(Macro expand)的原理是，m4按照token方式读取输入流，然后copy每个token到输出流上。但是如果这个token是一个宏定义，则M4会计算这个宏的展开，进一步读取输入流，来获取这个宏的参数。如果这个宏展开后的结果，是另一个宏的参数，那么这个结果会放入输入流中，用于继续处理。



关于token的定义是：任意字符不是宏名字、不是引号字符串或者注释，那么这个字符就是token。

官方文档描述[^9]，如下

> Any character, that is neither a part of a name, nor of a quoted string, nor a comment, is a token by itself. 

举个宏嵌套的例子，如下

```shell
$ cat macro_nested_expand.m4 
format(`Result is %d', eval(`2**15'))
$ m4 macro_nested_expand.m4 
Result is 32768
```

上面m4文件中有两个内置的宏format和eval。

显然首先宏展开的是eval，然后展开format宏。



完整的M4的宏展开过程，官方文档描述[^8]，如下

> As `m4` reads the input token by token, it will copy each token directly to the output immediately.
> 
> The exception is when it finds a word with a macro definition. In that case `m4` will calculate the macro’s expansion, possibly reading more input to get the arguments. It then inserts the expansion in front of the remaining input. In other words, the resulting text from a macro call will be read and parsed into tokens again.
> 
> `m4` expands a macro as soon as possible. If it finds a macro call when collecting the arguments to another, it will expand the second call first. This process continues until there are no more macro calls to expand and all the input has been consumed.



## 3、Macro invoke

TODO: https://www.gnu.org/software/m4/manual/html_node/Macros.html#Macros





## 4、File inclusion

m4有两种内置的宏[^2]支持文件包含(File inclusion)，如下

* include(`file')。宏展开file的内容，如果file路径不存在，则报错
* sinclude(`file')。宏静默展开file的内容，如果file路径不存在，则不会报错





## 5、常见问题

### (1) 报错recursive push_string!

MacOS上m4命令要求m4文件末尾必须空一行[^4]

举个引起报错的例子，如下

```shell
$ cat foo
bar%
$ m4 -Dbar=hello foo        
/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/m4: INTERNAL ERROR: recursive push_string!
[1]    62467 abort      m4 -Dbar=hello foo
```

正确的例子，如下

```shell
$ cat foo2
bar
$ m4 -Dbar=hello foo2
hello
```



## 6、TODO

syscmd

https://stackoverflow.com/questions/66306040/include-file-contents-using-m4-without-processing-them





## References

[^1]:https://www.gnu.org/software/m4/

[^2]:https://www.gnu.org/software/m4/manual/html_node/Include.html
[^3]:https://www.gnu.org/software/m4/manual/html_node/Command-line-files.html
[^4]:https://blog.csdn.net/qq_34149581/article/details/105004455
[^5]:https://www.gnu.org/software/m4/manual/html_node/Names.html#Names

[^6]:https://www.gnu.org/software/m4/manual/html_node/Quoted-strings.html
[^7]:https://www.gnu.org/software/m4/manual/html_node/Comments.html

[^8]:https://www.gnu.org/software/m4/manual/html_node/Input-processing.html
[^9]:https://www.gnu.org/software/m4/manual/html_node/Other-tokens.html

