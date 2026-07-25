-- string.gsub with patterns and replacement function
local text = "the quick brown fox jumps over the lazy dog"
local up, n = text:gsub("%w+", function(w) return w:sub(1,1):upper()..w:sub(2) end)
print(up, n)
local nums = "a1b22c333d4444"
local total = 0
nums:gsub("%d+", function(d) total = total + tonumber(d) end)
print("total", total)
print((("2026-07-25"):gsub("-", "/")))
