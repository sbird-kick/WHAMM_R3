-- closures capturing upvalues, counter factory
local function make(n)
  local c = n
  return function() c = c + 1; return c end
end
local a, b = make(0), make(100)
local s = 0
for i = 1, 50 do s = s + a() + b() end
print("s", s)
-- closures over loop var
local fns = {}
for i = 1, 10 do fns[i] = function() return i * i end end
local q = 0
for i = 1, 10 do q = q + fns[i]() end
print("q", q)
