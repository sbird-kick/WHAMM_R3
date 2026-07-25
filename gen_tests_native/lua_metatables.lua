-- metatables: __index chain, __add, __tostring
local Vec = {}
Vec.__index = Vec
Vec.__add = function(a, b) return setmetatable({x=a.x+b.x, y=a.y+b.y}, Vec) end
Vec.__tostring = function(v) return "("..v.x..","..v.y..")" end
function Vec.new(x, y) return setmetatable({x=x, y=y}, Vec) end
function Vec:len2() return self.x*self.x + self.y*self.y end
local sum = Vec.new(0, 0)
for i = 1, 20 do sum = sum + Vec.new(i, -i) end
print(tostring(sum), sum:len2())
