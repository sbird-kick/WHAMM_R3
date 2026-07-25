-- build a JSON-like serializer (recursion, string ops, no libs)
local function ser(v)
  local t = type(v)
  if t == "number" then return tostring(v)
  elseif t == "string" then return '"'..v..'"'
  elseif t == "boolean" then return tostring(v)
  elseif t == "table" then
    local isarr = #v > 0
    local parts = {}
    if isarr then
      for i = 1, #v do parts[i] = ser(v[i]) end
      return "["..table.concat(parts, ",").."]"
    else
      local keys = {}
      for k in pairs(v) do keys[#keys+1] = k end
      table.sort(keys)
      for _, k in ipairs(keys) do parts[#parts+1] = '"'..k..'":'..ser(v[k]) end
      return "{"..table.concat(parts, ",").."}"
    end
  end
  return "null"
end
local doc = {name="test", nums={1,2,3,4}, meta={active=true, count=42}}
print(ser(doc))
