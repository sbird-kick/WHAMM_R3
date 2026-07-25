-- string pattern matching: find, match, gmatch
local csv = "name=lua,ver=5.4,year=2025,arch=wasm"
local pairs_found = {}
for k, v in csv:gmatch("(%w+)=(%w+)") do pairs_found[#pairs_found+1] = k..":"..v end
print(table.concat(pairs_found, " "))
local s = "hello world 123 foo 456"
local sum = 0
for d in s:gmatch("%d+") do sum = sum + tonumber(d) end
print("sum", sum)
print(("  trim me  "):match("^%s*(.-)%s*$"))
print(string.find("abcdefabc", "abc", 2))
