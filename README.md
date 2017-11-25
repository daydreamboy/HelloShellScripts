# HelloShellScripts
--

### TOC

### 8. set

* `set -e`，脚本中任何命令执行失败，就停止执行脚本。如果不加，默认会继续执行脚本[^1]。

```
#!/bin/sh

# Note: any command execute failed will stop running this script
set -e

execute_none_command
echo "will not out put something if any above command failed"
```


References
--

[^1]: http://julio.meroh.net/2010/01/set-e-and-set-x.html