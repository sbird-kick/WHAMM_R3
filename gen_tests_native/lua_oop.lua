-- OOP with inheritance via metatables
local Animal = {}
Animal.__index = Animal
function Animal.new(name) return setmetatable({name=name, energy=10}, Animal) end
function Animal:eat(n) self.energy = self.energy + n; return self.energy end
function Animal:describe() return self.name.." e="..self.energy end
local Dog = setmetatable({}, {__index = Animal})
Dog.__index = Dog
function Dog.new(name) local d = Animal.new(name); return setmetatable(d, Dog) end
function Dog:bark() return self.name.." woof" end
local d = Dog.new("Rex")
d:eat(5)
print(d:describe(), d:bark())
local total = 0
for i = 1, 10 do local a = Animal.new("a"..i); total = total + a:eat(i) end
print("total", total)
