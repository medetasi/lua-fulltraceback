local fullTraceback = require "fullTraceback"

local function test(a, b)
    local c = a[1]
    local d = b[1]
    if c > d then
        print "ok"
    end
    if a[2] > b[2] then
        print "ok2"
    end
    if a[3] > b[3] then
        print "ok3"
    end
end

local a = {1, 2}
local b = {2, 3, "c"}
xpcall(test, function(error) print(error .. "\n" .. fullTraceback(3)) end, a, b)