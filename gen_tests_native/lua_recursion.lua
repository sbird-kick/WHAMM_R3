-- recursion: fib, ackermann(small), mutual recursion
local function fib(n) if n < 2 then return n end return fib(n-1) + fib(n-2) end
print("fib20", fib(20))
local function ack(m, n)
  if m == 0 then return n + 1 end
  if n == 0 then return ack(m-1, 1) end
  return ack(m-1, ack(m, n-1))
end
print("ack(2,3)", ack(2, 3))
local isEven, isOdd
isEven = function(n) if n == 0 then return true else return isOdd(n-1) end end
isOdd  = function(n) if n == 0 then return false else return isEven(n-1) end end
print("even30", isEven(30), "odd7", isOdd(7))
