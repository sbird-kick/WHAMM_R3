-- nested tables: matrix multiply
local function mat(n, fill)
  local m = {}
  for i = 1, n do m[i] = {} for j = 1, n do m[i][j] = fill(i, j) end end
  return m
end
local N = 8
local A = mat(N, function(i, j) return (i + j) % 5 end)
local B = mat(N, function(i, j) return (i * j) % 7 end)
local C = mat(N, function() return 0 end)
for i = 1, N do for j = 1, N do
  local s = 0
  for k = 1, N do s = s + A[i][k] * B[k][j] end
  C[i][j] = s
end end
local trace = 0
for i = 1, N do trace = trace + C[i][i] end
print("trace", trace, "corner", C[1][1], C[N][N])
