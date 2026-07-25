-- Sieve of Eratosthenes + collatz (integer heavy)
local N = 2000
local sieve = {}
for i = 2, N do sieve[i] = true end
for i = 2, math.floor(math.sqrt(N)) do
  if sieve[i] then for j = i*i, N, i do sieve[j] = false end end
end
local count, last = 0, 0
for i = 2, N do if sieve[i] then count = count + 1; last = i end end
print("primes", count, "largest", last)
local function collatz(n) local steps = 0 while n > 1 do if n % 2 == 0 then n = n // 2 else n = 3*n + 1 end steps = steps + 1 end return steps end
local maxsteps, maxn = 0, 0
for i = 1, 100 do local s = collatz(i); if s > maxsteps then maxsteps = s; maxn = i end end
print("collatz max steps", maxsteps, "at", maxn)
