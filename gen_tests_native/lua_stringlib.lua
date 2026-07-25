-- string library: byte, char, reverse, upper/lower, sub, len
local s = "Hello, Lua 5.4!"
print(s:upper(), s:lower())
print(s:reverse())
print("len", #s, "byte1", s:byte(1), "sub", s:sub(8, 10))
local codes = {}
for i = 1, #s do codes[i] = s:byte(i) end
local rebuilt = string.char(table.unpack(codes))
print("roundtrip", rebuilt == s)
local caesar = s:gsub("%a", function(c)
  local b = c:byte()
  if b >= 65 and b <= 90 then return string.char((b - 65 + 3) % 26 + 65) end
  if b >= 97 and b <= 122 then return string.char((b - 97 + 3) % 26 + 97) end
  return c
end)
print("caesar", caesar)
