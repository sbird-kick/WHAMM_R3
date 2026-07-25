-- bitwise operators (5.3+), integer math
local function popcount(x)
  local c = 0
  while x ~= 0 do c = c + (x & 1); x = x >> 1 end
  return c
end
local s = 0
for i = 0, 255 do s = s + popcount(i) end
print("popsum", s)
local h = 5381
for i = 1, 20 do h = ((h << 5) + h + i) & 0xFFFFFFFF end
print("hash", h)
print("xor/and/or", 0xF0 ~ 0x0F, 0xFF & 0x3C, 0x30 | 0x0C)
