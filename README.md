# Shell Script
[TOC]

## 1、关于Shell

MacOS支持多种Shell，默认是bash，但是个人觉得zsh比较好用。

| shell | 备注 |
| ----- | ---- |
| bash  |      |
| sh    |      |
| tcsh  |      |
| zsh   |      |







## 2、环境变量

### （1）$SHELL

默认shell的路径，例如

```shell
$ echo $SHELL
/bin/zsh
```

注意：

> 1. 当在Terminal中切换Shell时，并不修改$SHELL
> 2. 如果需要找当前生效的shell，可以使用`echo $0`来打印shell的名字[^7]。







## 3、常用命令

### （1） set

* `set -e`，脚本中任何命令执行失败，就停止执行脚本。如果不加，默认会继续执行脚本[^6]。

```shell
#!/bin/sh

# Note: any command execute failed will stop running this script
set -e

execute_none_command
echo "will not out put something if any above command failed"
```



### （2）grep

#### a. 语法格式

```shell
$ grep [options] <pattern> <path/to/folder or file>
```



#### b. 常用选项

##### `-r`

递归查找子文件夹。默认只在指定文件夹下查找，而不在它的所有子文件夹下查找



##### `-n`

输出匹配位置所在文件中的行号



##### `-i`

忽略查找字符串的大写敏感



##### `-l`

输出匹配文件的相对路径，相对于指定路径



##### `-C<number>`[^3]

显示上下文line的个数



##### `-A<number>`[^3]

显示上文line的个数



##### `-B<number>`[^3]

显示下文line的个数



##### `-e`

根据正则表达式匹配查找字符串。可以支持多个`-e`



##### `-v`

反向匹配。过滤显示不满足正则匹配的结果。



#### c. 常见用法

##### 目录中递归进行文本匹配

* 在某个文件夹下递归每个文件，并进行匹配

```shell
$ grep -r 'pjson' /usr/local/Cellar/chisel/1.5.0/libexec/commands 
/usr/local/Cellar/chisel/1.5.0/libexec/commands/FBPrintCommands.py:    return 'pjson'
```



* 递归搜索当前文件夹下所有文件，并进行匹配

```shell
$ grep -rni "string" *
```

>r，递归查找子文件夹    
>n，输出行号    
>i，大小写不敏感    



##### 指定多个pattern[^5]

允许多个`-e`，用于指定多个pattern，使用逻辑或

```shell
$ cat 1.txt | grep -e foo -e bar 
a bar
a foo
a football
```

或者使用简写形式

```shell
$ cat 1.txt | grep 'foo\|bar'
a bar
a foo
a football
```

注意：`|`必须使用反斜杠进行转义，而不支持`*`，可以支持`.`、`+`匹配



##### 匹配并替换文本

* 在某个目录下，对所有文件的内容进行字符串替换

```shell
$ grep -rl matchstring somedir/ | xargs sed -i 's/string1/string2/g'
```



##### 反向匹配

* 查找不是当前分支的其他分支

```shell
$ git branch | grep -v \*
```

当前分支总是以`*`前缀，使用`-v`，用于过滤git branch输出每行没有带`*`的结果。



### （3）pgrep

释义：process grep    
说明：在当前系统进程表中进行grep搜索   
示例：

```
$ pgrep debugserver
34486
```

* pgrep -x，准确匹配进程名（不包含子字符串）

* pgrep -fl，匹配进程名，并显示进程的启动参数

```
$ pgrep -fl lldb
38439 /Applications/Xcode-beta.app/Contents/Developer/usr/bin/lldb
93787 /Applications/Xcode.app/Contents/SharedFrameworks/LLDBRPC.framework/Resources/lldb-rpc-server --unix-fd 65 --fd-passing-socket 67
98211 sudo lldb -n helloptrace -w
98212 /Applications/Xcode-beta.app/Contents/Developer/usr/bin/lldb -n helloptrace -w
```



### （4）ps

#### a. 介绍

释义：process status

说明：输出进程的状态

示例：

* ps，输出当前用户的所有进程信息


* ps -f，显示各个字段的信息（UID、PID、PPID等）

* ps -p \<PID\>，输出匹配特定PID进程的信息

* 查找某个进程的启动参数

```
$ ps -fp `pgrep -x debugserver`
  UID   PID  PPID   C STIME   TTY           TIME CMD
  501 34934 34933   0  9:12PM ttys053    0:00.20 /Applications/Xcode-beta.app/Contents/SharedFrameworks/LLDB.framework/Resources/debugserver --native-regs --setsid --reverse-connect 127.0.0.1:61096
```

* ps -o field= \<PID\>，输出特定PID进程的某个指定field

```
$ ps -o ppid= $(pgrep -x debugserver)
36552
$ ps -fp `pgrep -x debugserver`      
  UID   PID  PPID   C STIME   TTY           TIME CMD
  501 36553 36552   0 10:21AM ttys053    0:00.21 /Applications/Xcode-beta.app/Contents/SharedFrameworks/LLDB.framework/Resources/debugserver --native-regs --setsid --reverse-connect 127.0.0.1:62479
```



#### b. 常用选项

##### `-e`

和`-A`一样，打印非自己启动的进程



##### `-a`

打印自己启动的进程，以及非自己启动的进程





### （5）md5

格式：md5 [-pqrtx] [-s string] [files ...]

示例：

```shell
$ md5 -s hell
MD5 ("hell") = 4229d691b07b13341da53f17ab9f2416
```



### （6）od

释义：octal, decimal, hex, ASCII dump工具

说明：按照某种进制输出数据



按照一个字节单位，十六进制dump字符串，如下[^4]

```shell
$ echo -n "Hello" | od -t x1
0000000    48  65  6c  6c  6f                                            
0000005
```

> -n，让echo输出不要带自动换行
>
> `-t x1`是`--format=x1`的简写，x代表hexidecimal，而1代表1个字节为单位



按照两个字节单位，十六进制dump字符串，如下

```shell
$ echo -n "Hello" | od -t x2
0000000      6548    6c6c    006f                                        
0000005
```

> 注意：上面使用little-endian方式，低地址放低位。因此，He输出为6548，先e（65）后H（48）



### （7）networksetup

#### a. 介绍

networksetup是configuration tool for network settings in System Preferences.



#### b. 常用示例

##### 清空DNS地址

```shell
$ networksetup -setdnsservers Wi-Fi Empty
```



### （8）ssh

#### a. 语法格式

```shell
ssh [-46AaCfGgKkMNnqsTtVvXxYy] [-B bind_interface] [-b bind_address] [-c cipher_spec] [-D [bind_address:]port] [-E log_file]
         [-e escape_char] [-F configfile] [-I pkcs11] [-i identity_file] [-J destination] [-L address] [-l login_name]
         [-m mac_spec] [-O ctl_cmd] [-o option] [-p port] [-Q query_option] [-R address] [-S ctl_path] [-W host:port]
         [-w local_tun[:remote_tun]] destination [command]
```



#### b. 常用选项

##### `-v`

打开verbose模式，可以有多个`-v`，最大支持3个，即`-vvv`，方便显示调试信息，用于诊断连接过程

```shell
$ ssh -vv root@192.168.0.107
```



#### c. 使用示例

##### 登录root用户

```shell
$ ssh root@<ip address> -p <port>
```

说明

> 1. 不指定`-p`，默认是22



### （9）ffmpeg



```shell
ffmpeg -i "https://cdn3.lajiao-bo.com/20190912/awZxKqhT/index.m3u8" -bsf:a aac_adtstoasc -vcodec copy -c copy -crf 50 file.mp4
```



### （10）find

#### a. 使用示例

##### 搜索指定文件夹并删除

当前目录下递归搜索delete文件夹并删除它 [^1] [^2]

```shell
$ find . -d -name "delete" -exec rm -r "{}" \;
```



### （11）mktemp

#### a. 介绍

​        mktemp用于在系统临时目录下生成随机的文件或者文件夹。当系统重启后，这些临时文件或者文件夹，会被系统清理掉。

举个例子，如下

```shell
$ mktemp
/var/folders/nb/0wzdfzd51p3_cdm5k4jdjwwc0000gp/T/tmp.j8llprlt
```



#### b. 常用选项

##### `-t`

指定文件或者文件夹的前缀名。如果不指定，默认是tmp。

```shell
$ mktemp -t MyTempFile
/var/folders/nb/0wzdfzd51p3_cdm5k4jdjwwc0000gp/T/MyTempFile.EDuxa2sh
```



##### `-d`

该选项表示创建临时文件夹。如果没有该选项，默认是创建文件。

```shell
$ mktemp -d
/var/folders/nb/0wzdfzd51p3_cdm5k4jdjwwc0000gp/T/tmp.1Rxz07It
$ ls -ld /var/folders/nb/0wzdfzd51p3_cdm5k4jdjwwc0000gp/T/tmp.1Rxz07It
drwx------  2 wesley_chen  staff  64 May  5 22:15 /var/folders/nb/0wzdfzd51p3_cdm5k4jdjwwc0000gp/T/tmp.1Rxz07It
```



### （12）whereis

whereis查询命令行工具的位置



### （13）zip

zip用于压缩文件或文件夹。举个例子，如下

```shell
$ zip -er archivename.zip path/to/folder
```



#### a. 常用选项

##### `-r`

压缩文件夹时，递归到里面的目录



#### `-e`

压缩使用密码



### （14）sed

sed (stream editor)命令行工具，是一个比较常用的文本编辑器。





References
--

[^1]: [grep - How can I recursively search for directory names with a particular string where the string is only part of the directory name - Ask Ubuntu](https://askubuntu.com/questions/153144/how-can-i-recursively-search-for-directory-names-with-a-particular-string-where)

[^2]: [rm - How to delete directories based on `find` output? - Unix & Linux Stack Exchange](https://unix.stackexchange.com/questions/89925/how-to-delete-directories-based-on-find-output)

[^3]: https://unix.stackexchange.com/questions/66196/how-to-run-grep-and-show-x-number-of-lines-before-and-after-the-match

[^4]:https://stackoverflow.com/questions/6791798/convert-string-to-hexadecimal-on-command-line
[^5]:https://unix.stackexchange.com/a/37316
[^6]: http://julio.meroh.net/2010/01/set-e-and-set-x.html
[^7]:https://stackoverflow.com/a/3327022



