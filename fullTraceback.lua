local function fullTraceback(level)
    local targetLevel = level
    local traceList = {"stack traceback:"}
    while true do
        local funcInfo = debug.getinfo(targetLevel)
        if not funcInfo then
            break
        end

        -- 源文件
        local traceInfo = string.format("\n\t(%d) %s:", targetLevel - (level - 1), funcInfo.short_src)
        -- 调用行数
        if funcInfo.currentline > 0 then
            traceInfo = string.format("%s%d:", traceInfo, funcInfo.currentline)
        end
        -- 处理函数名
        if string.len(funcInfo.namewhat) ~= 0 then
            traceInfo = string.format('%s in function "%s"', traceInfo, funcInfo.name or "?")
        else
            if funcInfo.what == "main" then
                traceInfo = string.format("%s in main chunk", traceInfo)
            elseif funcInfo.what == "C" or funcInfo.what == "tail" then
                traceInfo = string.format("%s ?", traceInfo)
            else
                traceInfo = string.format("%s in function <%s:%d>", traceInfo, funcInfo.short_src, funcInfo.linedefined)
            end
        end

        -- 处理local变量
        local localVarStr = ""
        local varNum = 1
        while true do
            local name, value = debug.getlocal(targetLevel, varNum)
            if not name then
                break
            end
            local format = type(value) == "string" and '\n\t\t"%s": "%s"' or '\n\t\t"%s": %s'
            localVarStr = localVarStr .. string.format(format, name, value)
            varNum = varNum + 1
        end

        -- 处理upvalue
        local upvalueStr = ""
        local upvalueNum = 1
        local func = funcInfo.func
        while true do
            local name, value = debug.getupvalue(func, upvalueNum)
            if not name then
                break
            end
            local format = type(value) == "string" and '\n\t\t"%s": "%s"' or '\n\t\t"%s": %s'
            upvalueStr = upvalueStr .. string.format(format, name, value)
            upvalueNum = upvalueNum + 1
        end

        table.insert(traceList, traceInfo)
        table.insert(traceList, localVarStr)
        table.insert(traceList, upvalueStr)
        targetLevel = targetLevel + 1
    end
    return table.concat(traceList)
end

return fullTraceback