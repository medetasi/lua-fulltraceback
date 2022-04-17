# lua-fulltraceback
使用 Lua 调试库实现的一个可以打印更多调试信息的函数。  
直接将文件放入工程中即可使用。  
一般在全局错误处理函数中调用即可，替换掉标准库的 debug.traceback 函数。

## 用法示例
test.lua 中有一个简单的示例，可以执行 lua ./test.lua 测试。  
一般的用法如下：
```Lua
local fullTraceback = require "fullTraceback"
function errorTrace(error)
    print(string.format("%s\n%s", error, fullTraceback(3)))
end

local function aaa(a, b)
end

xpacll(aaa, errorTrace, 1, 2)
```