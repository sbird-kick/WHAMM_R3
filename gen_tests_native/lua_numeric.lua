-- numeric loops, integer/float, math library (deterministic)
local si, sf = 0, 0.0
for i = 1, 1000 do si = si + i end
for i = 1, 100 do sf = sf + math.sqrt(i) end
print("si", si)
print("sf", string.format("%.4f", sf))
local f = 1
for i = 1, 15 do f = f * i end
print("15!", f)
print("floor/ceil", math.floor(3.7), math.ceil(3.2), math.max(3,9,1), math.min(3,9,1))
