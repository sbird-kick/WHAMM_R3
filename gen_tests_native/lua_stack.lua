-- data structures: stack, queue, linked list traversal
local Stack = {}
Stack.__index = Stack
function Stack.new() return setmetatable({items={}, n=0}, Stack) end
function Stack:push(v) self.n = self.n + 1; self.items[self.n] = v end
function Stack:pop() local v = self.items[self.n]; self.items[self.n] = nil; self.n = self.n - 1; return v end
local st = Stack.new()
for i = 1, 100 do st:push(i * i) end
local s = 0
for i = 1, 50 do s = s + st:pop() end
print("popped sum", s, "remaining", st.n)
-- linked list
local head = nil
for i = 1, 30 do head = {val = i, next = head} end
local acc, node = 0, head
while node do acc = acc + node.val; node = node.next end
print("list sum", acc)
