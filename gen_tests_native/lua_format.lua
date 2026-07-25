-- string.format variety
local out = {}
for i = 1, 20 do
  out[i] = string.format("%03d:%x:%o:%.2f", i, i*i, i, i/3)
end
print(table.concat(out, "|"))
print(string.format("%5.3g %e", 3.14159, 12345.678))
print(string.format("%q", "line\twith\"quote"))
