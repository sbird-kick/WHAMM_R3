-- table.sort with custom comparator (deterministic input)
local t = {}
for i = 1, 200 do t[i] = (i * 37 + 11) % 200 end
table.sort(t)
print("min", t[1], "max", t[#t])
table.sort(t, function(a, b) return a > b end)
print("first3", t[1], t[2], t[3])
local words = {"banana","apple","cherry","date","fig","grape"}
table.sort(words)
print(table.concat(words, ","))
