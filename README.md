# lua-fulltraceback
　　Lua 的 xpcall 可以指定一个错误消息处理函数，可以使用 Lua 自带的 debug.traceback，但是它可以显示的内容比较少，在调试的时候没那么好用，如果实现一个更好用的错误消息处理函数，可以一定程度上保存现场报错信息，提高不少 debug 的效率。  
　　使用时直接将文件放入工程中即可，一般在全局错误处理函数中调用。

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