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



### (1) 文件模块化

可以使用`source`命令(即`.`命令)来导入其他文件的函数[^14]。有下面两种写法，如下

* 使用`.`命令

```shell
. ./library.sh
```

* 使用`source`命令

```shell
source './library.sh'
```



一般将一些工具函数，放在单独的文件中，形成独立的模块文件。

举个例子，library.sh是一个模块文件，如下

```shell
#!/usr/bin/env bash

foo() {
    echo foo $1
}

test_foo() {
    foo 1
    foo 2
}

if [[ "${1}" == "--test" ]]; then
    test_foo "${@}"
fi
```

当library.sh接收选项`--test`时，则执行test_foo函数，否则不执行test_foo函数。这种方式可以用于在模块文件中，添加单测函数。



use_library.sh是使用library.sh的业务方代码，如下

```shell
#!/usr/bin/env bash

. ./library.sh

foo 3
```



### (2) 函数如何返回值

函数如何返回值，这篇文章[^18]给出四种方式来实现。本文总结有三种方式

* 使用全局变量

* 使用函数命令（echo命令和$(function)结合）
* 使用return语句

说明

> 1. 文中[^18]的**Example-3: Using Variable**的例子，实际也是使用全局变量实现，因此不能单独算作一种方式
> 2. 示例代码，见function_return_value.sh



#### 使用全局变量

使用全局变量的方式，比较容易理解，但是代码维护比较困难，一般不推荐使用这种方式。

举个例子，如下

```shell
# Style 1: use global variable
function return_value_using_global_variable() {
    return_value1='return value from function return_value_using_global_variable'
}

echo ${return_value1}
return_value_using_global_variable
echo ${return_value1}
```

这里全局变量return_value1，即使没有定义也可以使用，第一个echo ${return_value1}输出是空的。



#### 使用函数命令（echo命令和$(function)结合）

使用函数命令，即结合echo命令和$(function)调用的方式。这种方式比较推荐，也是比较常见的。

举个例子，如下

```shell
function return_value_using_echo() {
    local return_value='return value from function return_value_using_echo'
    echo ${return_value}
}

return_value2=$(return_value_using_echo)
echo ${return_value2}
```

注意

> return_value_using_echo函数，必须使用$(function)方式，不能直接调用，不然echo命令会将返回值直接输出到stdout中



#### 使用return语句

和其他语言一样，Shell也有return语句，但是这个return语句仅代表函数的返回状态，即错误码的概念。因此return不支持返回字符串，只能是数字。而且获取返回值，也只能通过`$？`获取。由于这些限制，这种方式使用起来不方便，不推荐使用。

举个例子，如下

```shell
function return_value_using_return_clause() {
    return 35
}

return_value3=$(return_value_using_return_clause)
echo ${return_value3}

return_value_using_return_clause
echo $?
```

这里echo ${return_value3}是没有输出的，必须使用`$？`获取返回值。

注意

> return语句返回字符串，shell执行会报错



#### 使用out parameter

在Bash 4.3+上支持nameref，可以用out parameter方式[^19]，来实现返回值。由于兼容性问题，不推荐这种比较前沿的方式。

举个例子，如下

```shell
function return_value_using_out_parameter() {
    local -n return_value=$1  # use nameref for indirection on Bash version 4.3+
    return_value='return value from function return_value_using_echo'
}

return_value_using_out_parameter ${return_value4}
echo ${return_value4}
```



### (3) 使用数组

#### 定义数组

Shell中使用一对括号来定义数组，如下

```shell
# Example1: array of numbers
array1=(1 2 3)
echo ${array1[0]}
echo ${array1[1]}
echo ${array1[2]}

# Example2: array of strings
array2=('1' '2' '3')
echo ${array2[0]}
echo ${array2[1]}
echo ${array2[2]}

# Example3: use string to create an array
string='a b    c'
array3=(${string})
declare -p array3

# Example4: use another array to create an array
init_array1=('x' 'y' 'z')
array4=(${init_array1[@]})
declare -p array4

# Example5: use another array to create an array
init_array2=('x y z')
array5=(${init_array2[@]})
declare -p array5
```

括号中可以是字面常量（数字、字符串），而可以是变量（字符串、另一个数组等）。



使用下标索引方式，可以获取到数组中的每个元素。如果要获取数组的所有元素，可以使用`array[@]`方式，如下

```shell
echo ${array2[@]}
```

它输出每个元素，并用空格分隔。

说明

> 1. 使用`${array2}`，是等价于`${array2[0]}`
> 2. 示例代码，见array_definition.sh





#### 操作数组 - 添加元素

添加元素，有2种方式

* 使用`+=`，可以添加另外一个数组。

* 使用`(array1[@] array2[@])`组合方式



举个例子，如下

```shell
# Example1: use array1+=array2
array1=(1 2 3)
array1+=(4 5 6)

echo ${array1[@]}

element='7'
array1+=(${element})
echo ${array1[@]}

# Example2:  use (array1[@] array2[@])
array2=(8)
array3=(9)
array4=(${array2[@]} ${array3[@]})
echo ${array4[@]}
```

> 示例代码，见array_elements_add.sh



#### 操作数组 - 删除元素

这篇文章[^20]提出三种方式来删除数组中的元素，如下

* 使用前缀匹配来删除元素
* 使用unset命令删除元素
* 使用子数组方式移除元素

> 示例代码，见array_elements_delete.sh



* 使用前缀匹配来删除元素

使用前缀匹配来删除元素，不推荐使用，因为本质不是删除元素，而是删除每个元素的前缀字符串。

举个例子，如下

```shell
function delete_elements_using_divide_sign() {
    array=(hello world hi)
    delete=(hello)
    echo ${array[@]/$delete}
    declare -p array

    delete=(h)
    echo ${array[@]/$delete}
    declare -p array
}
```

使用`${array[@]/$delete}`，将数组中每个元素进行前缀匹配，并删除前缀。当设置`delete=(h)`时，echo的输出结果是`ello world i`



* 使用unset命令删除元素

unset命令可以清除特定下标的元素。但是也不推荐使用，因为unset命令清除特定下标后，数组还是保留被清除的下标。例如数组中元素为1 2 3，使用unset命令清除下标0，然后再访问下标0的元素，得到是空，2和3依然位于下标1和2。

举个例子，如下

```shell
function delete_elements_using_unset() {
    array1=(1 2 3)
    unset "array1[0]"

    echo ${array1[@]}
    declare -p array1

    echo ${array1[0]} # not 2, but it's empty
}
```

说明

> 1. unset命令使用双引号是防止RubyMine中提示报错。
> 2. 使用declare -p，可以打印数组的内部结构



* 使用子数组方式移除元素

使用子数组方式移除元素的方式，比较tricky，实际是获取原数组中多个子数组，然后将多个子数组组合起来，达到删除特定元素的目的。不推荐使用，实现起来也不容易通用化。

举个例子，如下

```shell
function delete_elements_using_subarray() {
    array=('e1' 'e2' 'e3' 'e4' 'e5' 'e6')
    echo "${array[@]:0:2}" # get subarray [0,2) from the original array
    echo "${array[@]:3}" # get subarray [3,+] from the original array

    new_array=("${array[@]:0:2}" "${array[@]:3}") # make a new array from the two subarrays
    echo "${array[@]}"
}
```

这里借助了使用获取子数组的语法。

`${array[@]:0:2}`获取子数组，区间是[0,2)。

`${array[@]:3}`获取子数组，区间是[3,...]，即从下标3（包括3）到数组结尾



#### 操作数组 - 遍历元素

遍历数组中的元素，通过`${array[@]}`获取所有元素，然后结合for语句来实现。

关于下标变量，有两种使用方式

* 直接当成元素使用
* 当成下标使用

> 示例代码，见array_elements_enumerate.sh



举个例子，如下

```shell
declare -a arr=("element1" "element2" "element3")

# Example1: using $index
for i in "${arr[@]}"
do
   echo "$i"
done

# Example2: use $array[index]
for i in "${!arr[@]}"; do
   echo "${i} = ${arr[${i}]}"
done
```

可以看出下标变量是否当成元素使用，区分在于`${arr[@]}`和`${!arr[@]}`。



#### 操作数组 - 是否包含元素

SO这个回答[^21]，给一个比较正确的判断方式。通过字符串包含的方式（借助`=~`语法），来判断某个元素是否存在。

示意代码，如下

```shell
if [[ " ${array[*]} " =~ " ${value} " ]]; then
    # whatever you want to do when array contains value
fi

if [[ ! " ${array[*]} " =~ " ${value} " ]]; then
    # whatever you want to do when array doesn't contain value
fi
```

这里借助了字符串包含符号`=~`来判断某个元素是否存在。

处理逻辑，如下

* 使用`" ${array[*]} "`将数组展开成一个字符串，这个字符串前后都有一个空格。例如数组(1 2 3)，则会转成字符串" 1 2 3  "。

* 使用`" ${value} "`将被检查的item，也转成一个前后有一个空格的字符串
* 最后使用字符串包含符号`=~`来判断，前者字符串是否包含后者字符串



注意

> 1. 增加空格符，是必要的不能去掉。否则可能导致判断不准确。举个例子，如下
>
>    ```shell
>    function example_not_correct_when_remove_space() {
>        array=(1 2 3)
>        value='1 '
>    
>        if [[ "${array[*]}" =~ "${value}" ]]; then
>            echo "contains \"${value}\""
>        fi
>    
>        if [[ ! "${array[*]}" =~ "${value}" ]]; then
>            echo "not contains \"${value}\""
>        fi
>    }
>    ```
>
>    结果输出是contains的，但是实际是'1 '应该不能判断在数组中的。
>
>    示例代码，见array_elements_query_contains.sh
>
> 2. 使用`${array[*]}`而不是`${array[@]}`，简单来说`${array[*]}`当成是一个变量，而`${array[@]}`当成是多个变量[^22]。具体参考”`${array[*]}`和`${array[@]}` 的区别“这一节。



#### 操作数组 - 获取数组长度以及判空

获取数组的有特定的语法，如下

```shell
array=(1 2 3 4)
echo ${#array[@]}
```

> 示例代码，见array_check_empty.sh



获取数组长度后，可以进一步判断数组是否为空

```shell
array1=()
if [[ ${#array1[@]} -eq 0 ]]; then
    echo "empty"
else
    echo "not empty"
fi
```

> 示例代码，见array_check_empty.sh



#### 如何返回数组

Shell函数返回数组，是不支持的[^23]。但是可以通过其他方式来实现返回”数组“，这里介绍一种通过返回特定字符串（每个元素由空格分隔，后面简称”数组字符串“）的方式[^24]。

举个例子，如下

```shell
function create_some_array() {
    local -a a=('x86' 'i386' 'arm64')
    echo ${a[@]}
}
```

注意，这里create_some_array函数返回的值是数组，但是它仅包含一个元素，而且该元素是数组字符串。使用`declare -p`可以看到return_value的内容。

```shell
function create_some_array() {
    local -a a=('x86' 'i386' 'arm64')
    echo ${a[@]}
}

declare -a return_value=$(create_some_array)
declare -p return_value
```

显然，这种返回值，不是期望的数据。但是如果错误认为返回值是对的，则使用下面的代码遍历元素，居然是成功。如下

```shell
for i in ${return_value[@]}; do
   echo "${i}"
done
```

但是这种不加双引号的写法不规范，如果加上双引号，就发现这种遍历是错误的。

```shell
for i in "${return_value[@]}"; do
   echo "${i}"
done
```

那么怎么正确处理返回的数组字符串，有种简单方法，如下

```shell
real_array1=($(create_some_array))
declare -p real_array1
```

将返回值重新初始化另外一个数组。

或者使用read命令重新将字符串读入到数组中，如下

```shell
IFS=', ' read -r -a real_array2 <<< "${return_value}"
declare -p real_array2
```



#### 优雅实现删除元素

```shell
function array_remove_elements() {
    declare -a original_array=(${!1})
    declare -a elements_to_remove=(${!2})
    declare -a return_array=()

    for i in "${original_array[@]}"; do
        if [[ ! " ${elements_to_remove[*]} " =~ " ${i} " ]]; then
            return_array+=(${i})
        fi
    done

    echo ${return_array[@]}
}
```

> 示例代码，见array_tool.sh





#### `${array[*]}`和`${array[@]}` 的区别

简单来说`${array[*]}`当成是一个变量，而`${array[@]}`当成是多个变量[^22]。

* `${array[*]}`将数组中的元素组成一个变量，它的值是所有元素并有空格分隔
* `${array[@]}`代表每个元素的变量

举个例子，如下

```shell
# Example1: use ${array[@]}
array=(1 2 3)
for i in "${array[@]}"; do
    echo "example.$i"
done

echo '---------------'

# Example2: use ${array[*]}
array=(1 2 3)
for i in "${array[*]}"; do
    echo "example.$i"
done

# Example3: use ${array[@]}, ${array[*]} with printf
printf 'data: ---%s---\n' "${array[@]}"
printf 'data: ---%s---\n' "${array[*]}"
```

`for i in "${array[@]}"`将执行3次echo，而`for i in "${array[*]}"`则只执行一次echo。第三个example也是一样的逻辑。



### (4) 历史展开功能

Shell中为了减少打字，可以使用历史展开功能，比如使用简单的符号，展开成历史输入的某些命令。

分为命令和单词展开2类[^26]，如下

* 命令展开。使用!表示展开，后面不能跟着空格、换行等。`!n`表示第n个命令

* 单词展开。使用$表示展开。



#### a. `!$`

`!$`结合`!`和`$`，表示展开上个命令的最后一个单词。

举个例子，如下

```shell
$ echo Unix and Linux
Unix and Linux
$ echo !$
$ echo Linux
```

当执行`echo !$`回车后，Shell终端会自动回显出`echo Linux`，这样实现展开功能。

`!$`具体有什么作用，一般用于避免再次输入文件夹或者文件名。

举个例子，如下

```shell
$ mkdir a_long_long_dir
$ cd !$
$ cd a_long_long_dir
```





### (5) 条件判断`[]`

TODO: https://stackoverflow.com/questions/33569061/purpose-of-square-brackets-in-shell-scripts





## 2、环境变量

### (1) $SHELL

默认shell的路径，例如

```shell
$ echo $SHELL
/bin/zsh
```

注意：

> 1. 当在Terminal中切换Shell时，并不修改$SHELL
> 2. 如果需要找当前生效的shell，可以使用`echo $0`来打印shell的名字[^7]。



### (2) $FUNCNAME

FUNCNAME变量是一个数组变量，包含函数调用栈的信息，当前函数是`${FUNCNAME[0]}`，它的一级调用者是`${FUNCNAME[1]}`，它的二级调用者是`${FUNCNAME[2]}`，依次类推。

举个例子，如下

```shell
#!/usr/bin/env bash

foo() {
    echo ${FUNCNAME[0]}  # prints 'foo'
    echo ${FUNCNAME[1]}  # prints 'bar'
    echo ${FUNCNAME[2]}  # prints 'main'
    echo ${FUNCNAME[3]}  # no output
    echo ${FUNCNAME[4]}  # no output
}

bar() { foo; }
bar
```

> 示例代码，见function_get_function_name.sh



关于FUNCNAME变量，GNU文档描述[^15]，如下

> ```
> FUNCNAME
> ```
>
> An array variable containing the names of all shell functions currently in the execution call stack. The element with index 0 is the name of any currently-executing shell function. The bottom-most element (the one with the highest index) is `"main"`. This variable exists only when a shell function is executing. Assignments to `FUNCNAME` have no effect. If `FUNCNAME` is unset, it loses its special properties, even if it is subsequently reset.
>
> This variable can be used with `BASH_LINENO` and `BASH_SOURCE`. Each element of `FUNCNAME` has corresponding elements in `BASH_LINENO` and `BASH_SOURCE` to describe the call stack. For instance, `${FUNCNAME[$i]}` was called from the file `${BASH_SOURCE[$i+1]}` at line number `${BASH_LINENO[$i]}`. The `caller` builtin displays the current call stack using this information.







## 3、常用命令

### (1) set

* `set -e`，脚本中任何命令执行失败，就停止执行脚本。如果不加，默认会继续执行脚本[^6]。

```shell
#!/bin/sh

# Note: any command execute failed will stop running this script
set -e

execute_none_command
echo "will not out put something if any above command failed"
```



### (2) grep

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

根据正则表达式匹配查找字符串。可以支持多个`-e`，它们是逻辑OR的关系。



##### `-v`

反向匹配。过滤显示不满足正则匹配的结果[^31]。

man手册描述，如下

> **-v**, **--invert-match**
>
> ​       Selected lines are those not matching any of the specified patterns.

举个例子，如下

```shell
$ git branch | grep \*
* release/v1.1.0
$ git branch | grep -v \*
...
```

上面使用`-v`的命令，用于过滤出现每行中没有*号的行。





##### `--color=always`

将匹配关键词高亮。

```shell
export GREP_OPTIONS='--color=always'
export GREP_COLOR='1;35;40'
```

https://superuser.com/a/417152



查找alias在哪里定义

```shell
$ zsh -ixc : 2>&1 | grep grep
```

https://unix.stackexchange.com/questions/322459/is-it-possible-to-check-where-an-alias-was-defined





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



### (3) pgrep

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



### (4) ps

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





### (5) md5

格式：md5 [-pqrtx] [-s string] [files ...]

示例：

```shell
$ md5 -s hell
MD5 ("hell") = 4229d691b07b13341da53f17ab9f2416
```



### (6) od

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



### (7) networksetup

#### a. 介绍

networksetup是configuration tool for network settings in System Preferences.



#### b. 常用示例

##### 清空DNS地址

```shell
$ networksetup -setdnsservers Wi-Fi Empty
```



### (8) ssh

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



### (9) ssh-keygen

如何生成多个ssh key[^27]，如下

```shell
$ cd ~/.ssh
$ ssh-keygen -t rsa
```

当执行`ssh-keygen -t rsa`，重新指定文件名，比如id_rsa_github

```shell
$ touch config
$ vim config
```

然后编辑~/.ssh/config文件，如下

```properties
Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_rsa_private_server
  IdentityFile ~/.ssh/id_rsa_github
  IdentityFile ~/.ssh/id_rsa_work_server
```

指定多个id_rsa_xxx文件



说明

> TODO: https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent



### (10) ffmpeg



```shell
ffmpeg -i "https://cdn3.lajiao-bo.com/20190912/awZxKqhT/index.m3u8" -bsf:a aac_adtstoasc -vcodec copy -c copy -crf 50 file.mp4
```



### (11) find

#### a. 使用示例

##### 搜索指定文件夹并删除

当前目录下递归搜索delete文件夹并删除它 [^1] [^2]

```shell
$ find . -d -name "delete" -exec rm -r "{}" \;
```



### (12) mktemp

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



### (13) whereis

whereis查询命令行工具的位置



### (14) TODO



### (15) sed

#### a. 介绍

sed (stream editor)命令行工具，是一个比较常用的文本编辑器。目前有两个版本的sed，一个是BSD版本，一个是[GNU版本](https://www.gnu.org/software/sed/manual/html_node/index.html#SEC_Contents)。不同版本的sed语法结构和支持能力是不一样，但是有些基本语法，这两个版本是通用的。

> 本文介绍sed是BSD版本，在MacOS上可操作执行。



sed的语法比较多，但通用的调用格式，如下

```shell
sed [-Ealnru] command [file ...]
sed [-Ealnr] [-e command] [-f command_file] [-I extension] [-i extension] [file ...]
```

一般使用不带option，而且是上面第一个格式，即

```shell
sed command [file ...]
```

这里command相当于sed的子命令，有它自身语法格式，如下

```shell
[addr]X[options]
```

简单来说，command由addr、X和options组成，它们的含义如下

* addr（可选），代表行号、正则表达式或者行号的范围
* X，特定的子命令（后面称sed command），具体可以参考这篇文档[^9]

* options（可选），用于修饰某些sed command



sed文档描述[^8]，如下

> X is a single-letter `sed` command. `[addr]` is an optional line address. If `[addr]` is specified, the command X will be executed only on the matched lines. `[addr]` can be a single line number, a regular expression, or a range of lines (see [sed addresses](https://www.gnu.org/software/sed/manual/html_node/sed-addresses.html#sed-addresses)). Additional `[options]` are used for some `sed` commands.



基于上面结构，sed命令主要功能，有下面几个部分

* 选择行 ([Addresses: selecting lines](https://www.gnu.org/software/sed/manual/html_node/sed-addresses.html#sed-addresses))，基于行号或者正则表达式
* 选择文本 ([Regular Expressions: selecting text](https://www.gnu.org/software/sed/manual/html_node/sed-regular-expressions.html#sed-regular-expressions))，基于正则表达式

在后面的“选择行”和“选择文本”两节中，会详细介绍。



#### b. sed命令选项

sed命令选项，主要是指下面使用`-`的参数，例如`-n`、`-f`等

```shell
sed [-Ealnru] command [file ...]
sed [-Ealnr] [-e command] [-f command_file] [-I extension] [-i extension] [file ...]
```



##### `-n`选项

sed命令处理输入，是按照行来处理的。默认sed每处理一行，都会把当前处理的行回显到stdout中。如果指定`-n`，则不显示回显。

举个例子，如下

```shell
$ cat bar.txt 
Hello,
world!%
```

> %表示末尾没有换行符



使用`-n`输出，如下

```shell
$ sed -n 1,2p bar.txt
Hello,
world!%                        
```

不使用`-n`输出，如下

```shell
$ sed 1,2p bar.txt 
Hello,
Hello,
world!world!%
```

> 1. 1,2p是选择行的语法，表示选择第一行到第二行[^12]
> 2. 由于sed是按照行处理的，每当一行处理完，会满足条件（行号、正则表达式等）的行输出到stdout。如果没有`-n`，则把当前处理的行，也会输出处理。



对于不同sed command，不带`-n`的输出也是不一样的。举个例子，如下

```shell
$ cat bar.txt 
Hello,
world!%
$ sed 's/He/bl/' bar.txt  
blllo,
world!%
$ sed -n 's/He/bl/' bar.txt
```

对于sed command的s command（具体参考“s command”一节），`-n`就是不输出处理的结果。



#### c. sed command

##### s command[^10]

s command是sed command的一种，比较常用，所以单独介绍一下。它的语法结构，如下

```shell
s/regexp/replacement/[flags]
```

s应该是substitute的缩写，该命令用于正则表达式匹配并替换。

参考这篇文档的描述[^11]，如下

> (substitute) Match the regular-expression against the content of the pattern space. If found, replace matched string with replacement.





#### d. 选择行





#### e. 选择文本







### (16) seq

#### a. 介绍

seq用于按照一定顺序打印数字



#### b. 语法格式

```shell
$ seq [-w] [-f format] [-s string] [-t string] [first [incr]] last
```



#### c. 使用示例

```shell
$ seq 3
1
2
3
$ seq 2 3
2
3
```



### (16) man

#### a. 介绍

man（manual）命令，是用于查看命令、系统调用、C库函数等的使用手册。

man将各种使用手册，分为下面8大类，如下

```shell
The standard sections of the manual include:
1      User Commands
2      System Calls
3      C Library Functions
4      Devices and Special Files
5      File Formats and Conventions
6      Games et. Al.
7      Miscellanea
8      System Administration tools and Deamons
```



#### b. 语法格式

```shell
$ man [OPTION]... [COMMAND NAME]...
```



#### c. 使用示例

##### 1. 查看某个命令的手册

```shell
$ man man
```

说明

> 如果要全部输出，可以使用`man <command> | cat`。



##### 2. 查看指定某个分类下的命令[^17]

```shell
$ man 2 open
```

如果某个命令代表的含义比较多，比如open即可以是open命令，也可以是C函数open，因此可以指定分类的编号。



##### 3. 查看命令的所有分类编号[^17]

```shell
$ man -f mmap
```

使用`-f`选项，可以查看命令在哪个分类



##### 4. 打开该命令所有的手册内容[^17]

```shell
$ man -a mmap
```

可以使用`-a`选项，打开命令对应的所有手册。不过有些的命令，对应很多个手册，输出的内容将会很多。这个命令实际用处也不大。



##### 5. 打开命令的所在文件[^17]

```shell
$ man -w mmap
```

可以使用`-w`选项，显示命令对应手册所在的文件路径。可以看出命令对应的手册信息，其实是以文件的形式存放的。



### (17) nc

nc (netcat)，主要用于测试网络进程。



#### a. 测试tcp端口的连通性

```shell
$ nc -zv 127.0.0.1 9000
```

* -v，表示给出详细输出
* -z，表示只扫描listening进程，并不发送任何给它们



#### b. 测试udp端口的连通性

举个例子，如下

```shell
$ nc -z -u a.b.c.d 8888
```

* -u，表示只扫描支持udp协议的端口



#### c. 向某个长连接server发送数据

举个例子[^32]，如下

```objective-c
$ echo "Hello from terminal" | nc -v 169.254.82.58 51533
Connection to 169.254.82.58 port 51533 [tcp/*] succeeded!
Welcome to the AsyncSocket Echo Server
```

最后一行信息，是长连接server返回的。



### (18) zip/unzip

#### a. zip

zip用于压缩文件或文件夹。举个例子，如下

```shell
$ zip -er archivename.zip path/to/folder
```



#### a. 常用选项

##### `-r`

压缩文件夹时，递归到里面的目录



##### `-e`

压缩使用密码



TODO

https://stackoverflow.com/questions/36323139/zip-two-file-with-same-content-but-final-md5sum-is-different



#### b. unzip

unzip -l zipfile

https://superuser.com/questions/216617/view-list-of-files-in-zip-archive-on-linux





### (19) realpath



### (20) md5sum

https://www.quora.com/What-is-the-difference-between-OS-X-MD5-and-GNU-MD5sum



TODO:https://unix.stackexchange.com/questions/109625/shell-scripting-z-and-n-options-with-if



### (21) alias/unalias

#### a. alias

##### 查看所有别名

```shell
$ alias
```

##### 搜索某个别名

```shell
$ alias | grep list
gcf='git config --list'
gdct='git describe --tags $(git rev-list --tags --max-count=1)'
gstl='git stash list'
```

##### 设置别名

```shell
$ alias list='ls -l'
$ list
total 248
...
```

注意

> 如果需要别名一直生效，则需要在对应shell的配置文件中设置`alias list='ls -l'`



#### b. unalias

##### 移除别名[^30]

```shell
$ unalias list
```





## 4、Ctrl+z

当执行命令时，命令未结束时，执行`Ctrl+z`，将挂起这个进程[^28]，并返回。

涉及到几个命令

* fg，将最近的进程设置为前台
* bg，将最近的进程设置为后台
* jobs，列出所有挂起的进程[^29]





## 5、使用zsh

### (1) 命令行提示增加时间[^13]

在`~/.zshrc`文件中，增加下面一行，如下

```shell
PROMPT='%{$fg[yellow]%}[%D{%f/%m/%y} %D{%T}] '$PROMPT
```



## 6、常见任务

### (1) 修改Podfile中的pod版本号

在CI系统中，提交打包好的pod产物，有时候需要自动修改主工程的Podfile，因此需要shell脚本支持。

如果主工程的Podfile都采用下面形式，如下

```ruby
pod 'xxx',
pod 'yyy/zzz', '1.2.3'
```

说明

> pod的形式，实际是pod方法，它的入参还有hash类型，比如:path => 'path/to/podspec', :git=> 'xxx.git'等。这里暂时不考虑这些形式。

这个shell脚本的主要逻辑是：使用sed提取`pod 'xxx',`部分和后面的部分，然后替换后面的部分为新的版本号。

举个例子，如下

TODO



## 附录

### 1、MacOS常用使用技巧

#### (1) 以root用户登录shell[^16]

```shell
$ sudo -i
Password: <your login password>
# whoami
root
```



TODO: https://superuser.com/questions/159486/how-to-kill-process-in-mac-os-x-and-not-have-it-restart-on-its-own



#### (2) 查看某个命令的位置

使用`type -a <command>`方式，可以该命令的所有位置[^25]

```shell
$ type -a ls
ls is an alias for ls -G
ls is /bin/ls
```





References
--

[^1]: [grep - How can I recursively search for directory names with a particular string where the string is only part of the directory name - Ask Ubuntu](https://askubuntu.com/questions/153144/how-can-i-recursively-search-for-directory-names-with-a-particular-string-where)

[^2]: [rm - How to delete directories based on `find` output? - Unix & Linux Stack Exchange](https://unix.stackexchange.com/questions/89925/how-to-delete-directories-based-on-find-output)

[^3]: https://unix.stackexchange.com/questions/66196/how-to-run-grep-and-show-x-number-of-lines-before-and-after-the-match

[^4]:https://stackoverflow.com/questions/6791798/convert-string-to-hexadecimal-on-command-line
[^5]:https://unix.stackexchange.com/a/37316
[^6]: http://julio.meroh.net/2010/01/set-e-and-set-x.html
[^7]:https://stackoverflow.com/a/3327022

[^8]:https://www.gnu.org/software/sed/manual/html_node/sed-script-overview.html#sed-script-overview
[^9]:https://www.gnu.org/software/sed/manual/html_node/sed-commands-list.html#sed-commands-list
[^10]:https://www.gnu.org/software/sed/manual/html_node/The-_0022s_0022-Command.html#The-_0022s_0022-Command
[^11]:https://www.gnu.org/software/sed/manual/html_node/sed-commands-list.html#sed-commands-list
[^12]:https://alexharv074.github.io/2019/04/16/a-sed-tutorial-and-reference.html#select-lines-by-range

[^13]:https://stackoverflow.com/a/48341347

[^14]:https://stackoverflow.com/questions/12815774/importing-functions-from-a-shell-script
[^15]:https://www.gnu.org/software/bash/manual/html_node/Bash-Variables.html

[^16]:https://superuser.com/questions/592323/how-do-i-become-root-on-mac-os-x/592324

[^17]:https://www.geeksforgeeks.org/man-command-in-linux-with-examples/

[^18]:https://linuxhint.com/return-string-bash-functions/
[^19]:https://stackoverflow.com/a/49971213
[^20]:https://linuxhint.com/remove-specific-array-element-bash/
[^21]:https://stackoverflow.com/a/15394738
[^22]:https://unix.stackexchange.com/questions/135010/what-is-the-difference-between-and-when-referencing-bash-array-values
[^23]:https://cjungmann.github.io/yaddemo/docs/bashreturnarray.html
[^24]:https://stackoverflow.com/a/24100864

[^25]:https://stackoverflow.com/questions/2869100/shell-how-to-find-directory-of-some-command

[^26]:https://unix.stackexchange.com/questions/254568/shell-command-cd

[^27]:https://stackoverflow.com/questions/24392657/adding-an-rsa-key-without-overwriting

[^28]:https://superuser.com/questions/476873/what-is-effect-of-ctrl-z-on-a-unix-linux-application
[^29]:https://unix.stackexchange.com/questions/45025/how-to-suspend-and-bring-a-background-process-to-foreground

[^30]:https://askubuntu.com/questions/325368/how-do-i-remove-an-alias

[^31]:https://superuser.com/questions/537619/grep-for-term-and-exclude-another-term

[^32]:https://superuser.com/questions/206791/what-is-the-simplest-way-to-test-a-plain-socket-server

