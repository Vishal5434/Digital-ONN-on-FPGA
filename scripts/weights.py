import numpy as np

# -------- Digit patterns (10 x 6) --------
# 1  = black
# -1 = white

digit0 = np.array([
-1,-1,-1,-1,-1,-1,
-1, 1, 1, 1, 1,-1,
-1, 1, 1, 1, 1,-1,
-1, 1, 1, 1, 1,-1,
-1, 1, 1, 1, 1,-1,
-1, 1, 1, 1, 1,-1,
-1, 1, 1, 1, 1,-1,
-1, 1, 1, 1, 1,-1,
-1, 1, 1, 1, 1,-1,
-1,-1,-1,-1,-1,-1
])

digit1 = np.array([
 1, 1,-1,-1, 1, 1,
 1,-1,-1,-1, 1, 1,
 1, 1,-1,-1, 1, 1,
 1, 1,-1,-1, 1, 1,
 1, 1,-1,-1, 1, 1,
 1, 1,-1,-1, 1, 1,
 1, 1,-1,-1, 1, 1,
 1, 1,-1,-1, 1, 1,
 1, 1,-1,-1, 1, 1,
-1,-1,-1,-1,-1,-1
])

digit2 = np.array([
-1,-1,-1,-1,-1,-1,
 1, 1, 1, 1,-1,-1,
 1, 1, 1, 1,-1,-1,
-1,-1,-1,-1,-1,-1,
-1,-1, 1, 1, 1, 1,
-1,-1, 1, 1, 1, 1,
-1,-1, 1, 1, 1, 1,
-1,-1, 1, 1, 1, 1,
-1,-1, 1, 1, 1, 1,
-1,-1,-1,-1,-1,-1
])

digit3 = np.array([
-1,-1,-1,-1,-1,-1,
 1, 1, 1, 1,-1,-1,
 1, 1, 1, 1,-1,-1,
-1,-1,-1,-1,-1,-1,
 1, 1, 1, 1,-1,-1,
 1, 1, 1, 1,-1,-1,
 1, 1, 1, 1,-1,-1,
 1, 1, 1, 1,-1,-1,
 1, 1, 1, 1,-1,-1,
-1,-1,-1,-1,-1,-1
])

patterns = [digit0, digit1, digit2, digit3]

# -------- Network size --------
rows = 10
cols = 6
N = rows * cols

# -------- Weight matrix --------
W = np.zeros((N, N))

for p in patterns:
    W += np.outer(p, p)

# remove self connections
np.fill_diagonal(W, 0)

W = W.astype(int)

# limit weight range
W = np.clip(W, -31, 31)

# -------- Write weights.mem --------
with open("weights.mem", "w") as f:
    for i in range(N):
        for j in range(N):
            value = W[i][j] & 0x3F
            f.write(f"{value:02x}\n")
