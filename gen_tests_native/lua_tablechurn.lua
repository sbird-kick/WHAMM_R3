-- table insert/remove churn + rehash
local t = {}
for i = 1, 500 do t[i] = (i * 7) % 101 end
for i = 1, 250 do table.remove(t, 1) end
for i = 1, 300 do t[#t + 1] = i end
local s = 0
for _, v in ipairs(t) do s = s + v end
print("sum", s, "len", #t)
