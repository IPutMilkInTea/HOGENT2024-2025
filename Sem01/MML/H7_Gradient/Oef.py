import numpy as np
f = lambda x : x[0]*x[0] + 2*x[1]*x[1]
g = lambda x : np.array([2*x[0], 4*x[1]])
alpha = 0.1
curr = np.array([1,1])
for _ in range(10):
  print(f”{curr[0]:.5f}, {curr[1]:.5f}, {f(curr):.5f}”)
  curr = curr - alpha * g(curr)