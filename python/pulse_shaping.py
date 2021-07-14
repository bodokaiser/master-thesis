import numpy as np

from matplotlib import pyplot as plt

from raised_root_cosine import rrc_coeffs

# reproducible
np.random.seed(42)

# random input
n_in = 8
T_in = 1e-3
x_in = np.random.uniform(-1, 1, n_in)
t_in = np.arange(n_in) * T_in
X_in = np.fft.fft(x_in)
P_in = np.abs(X_in) ** 2
f_in = np.fft.fftfreq(n_in, T_in)

# upsampling
us_f = 4
n_us = n_in * us_f
T_us = T_in / us_f
x_us = np.zeros(n_us)
x_us[::us_f] = x_in
t_us = np.arange(n_us) * T_us
X_us = np.fft.fft(x_us)
P_us = np.abs(X_us) ** 2
f_us = np.fft.fftfreq(n_us, T_us)

# digital filtering
df = rrc_coeffs(32, 0.8, 2)
n_df = n_us
T_df = T_us
t_df = t_us
X_df = np.multiply(df, X_us)
P_df = np.abs(X_df) ** 2
f_df = np.fft.fftfreq(n_df, T_df)
x_df = np.fft.ifft(X_df).real

# setup time-frequency plot
fig, axes = plt.subplots(nrows=4, ncols=2, figsize=(10, 14))
for ax in axes:
    ax[0].set_ylabel(r"Amplitude $x(t)$")
    ax[1].set_ylabel(r"Magnitude $\vert X(f)\vert^2/P$")
    ax[1].set_yscale("log")
    ax[0].set_xlim([-1, 9])
    ax[0].set_ylim([-1.2, +1.2])
    # ax[1].set_ylim([0, 0.4])
    ax[1].set_xlim([-0.6, 0.6])
    ax[1].yaxis.set_label_position("right")
    ax[1].yaxis.tick_right()
axes[-1][0].set_xlabel(r"Time $t/T$")
axes[-1][1].set_xlabel(r"Frequency $fT$")
# add input samples
axes[0][0].stem(t_in / T_in, x_in)
axes[0][1].bar(f_in * T_in, P_in / P_in.sum(), 100 * T_in)
# add upsampled samples
axes[1][0].stem(t_us / T_in, x_us)
axes[1][1].bar(f_us * t_us, P_us / P_in.sum(), 100 * T_in)
# add digital filtered samples
axes[2][0].stem(t_df / T_in, x_df)
axes[2][1].bar(f_df * t_df, P_df, 100 * T_in)
# save as image
plt.savefig("pulse-shaping.png")
