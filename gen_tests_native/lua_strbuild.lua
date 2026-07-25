-- string building via table.concat and .. accumulation
local parts = {}
for i = 1, 200 do parts[i] = string.rep("ab", i % 5) .. i end
local joined = table.concat(parts, "-")
print("len", #joined)
local acc = ""
for i = 1, 60 do acc = acc .. tostring(i % 10) end
print("acc", acc)
