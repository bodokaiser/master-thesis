import numpy as np
import raised_root_cosine as rcc

from matplotlib import pyplot as plt

np.random.seed(42)

# number of symbols
nos = 8
# samples per symbol
sps = 4

# random input
x1 = np.random.uniform(-1, 1, nos)
t1 = np.arange(nos)
f1 = (np.linspace(0, 1, len(x1)) - 0.5) / len(x1)
P1 = np.abs(np.fft.fft(x1)) ** 2

# upsampling
x2 = np.zeros(nos * sps)
x2[::sps] = x1
t2 = np.linspace(0, nos, len(x2))
f2 = (np.linspace(0, 1, len(x2)) - 0.5) / len(x2)
P2 = np.abs(np.fft.fft(x2)) ** 2

# pulse-shaping
X3 = np.fft.fft(x2) * rcc.transfer(len(x2), 0.8, len(x2) // (2 * sps))
x3 = np.fft.ifft(x2).real
P3 = np.abs(X3) ** 2

plt.figure(figsize=(10, 6))
plt.subplot(321)
plt.stem(t1, x1)
plt.xlim([-1, 8])
plt.subplot(322)
plt.bar(f1, P1, 5e-3)
plt.subplot(323)
plt.stem(t2, x2)
plt.xlim([-1, 8])
plt.subplot(324)
plt.bar(f2, P2, 2e-4)
plt.subplot(325)
plt.stem(t2, x3)
plt.xlim([-1, 8])
plt.subplot(326)
plt.bar(f2, P3, 2e-4)
plt.savefig("pulse-shaping.png")