# Shell on Mac
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



### $SHELL

默认shell的路径，例如

```shell
$ echo $SHELL
/bin/zsh
```

注意：

> 1. 当在Terminal中切换Shell时，并不修改$SHELL
> 2. 如果需要找当前生效的shell，可以使用`echo $0`来打印shell的名字[^2]。







## 2、常用基础命令



### 1. set

* `set -e`，脚本中任何命令执行失败，就停止执行脚本。如果不加，默认会继续执行脚本[^1]。

```shell
#!/bin/sh

# Note: any command execute failed will stop running this script
set -e

execute_none_command
echo "will not out put something if any above command failed"
```





References
--

[^1]: http://julio.meroh.net/2010/01/set-e-and-set-x.html
[^2]:https://stackoverflow.com/a/3327022



