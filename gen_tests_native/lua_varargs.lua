-- varargs, select, table.pack/unpack
local function sum(...)
  local s = 0
  for i = 1, select("#", ...) do s = s + select(i, ...) end
  return s
end
print("sum", sum(1,2,3,4,5,6,7,8,9,10))
local function stats(...)
  local t = table.pack(...)
  local mn, mx = math.huge, -math.huge
  for i = 1, t.n do mn = math.min(mn, t[i]); mx = math.max(mx, t[i]) end
  return mn, mx, t.n
end
print("stats", stats(5, 3, 9, 1, 7, 2))
local args = {10, 20, 30}
print("unpack", table.unpack(args))
