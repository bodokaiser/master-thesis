import numpy as np


def transfer(size, beta, cutoff):
    coeffs = np.zeros(size)
    center = size // 2

    range0 = (1 - beta) * cutoff
    range1 = (1 + beta) * cutoff

    if size < 2 * (1 + np.floor(range1)):
        raise Exception("filter size too small")

    i = 0
    while i < np.floor(range0):
        coeffs[center + i] = 1.0
        coeffs[center - i] = 1.0
        i += 1
    while i < np.floor(range1):
        arg = np.pi * (i - range0) / (2 * beta * cutoff)
        rc = 0.5 * (1.0 + np.cos(arg))
        coeffs[center + i] = rc
        coeffs[center - i] = rc
        i += 1

    return coeffs


if __name__ == "__main__":
    from matplotlib import pyplot as plt

    plt.title("Raised-root-cosine")
    plt.plot(rrc_coeffs(32, 0.0, 4), label=r"\beta=0")
    plt.plot(rrc_coeffs(32, 0.8, 4), label=r"\beta=0.8")
    plt.plot(rrc_coeffs(32, 1.0, 4), label=r"\beta=1.0")
    plt.savefig("raised-root-cosine.png")
