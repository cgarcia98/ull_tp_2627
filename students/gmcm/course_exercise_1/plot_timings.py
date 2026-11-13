"""Figure of the timing study of course exercise 1.

Reads timings.csv, written by timing.sh, and draws timing.png:

  left:  the median wall-clock time against the number of particles N,
         for the serial program and each number of threads
  right: the speed-up S(p) = T(1) / T(p) against the number of threads p,
         for each N, with the ideal speed-up S(p) = p

Usage: python3 plot_timings.py   (needs matplotlib)
"""
import csv
from collections import defaultdict
from statistics import median

import matplotlib
matplotlib.use("Agg")   # write the file, without opening a window
import matplotlib.pyplot as plt

# Every run in timings.csv, grouped by (N, threads)
times = defaultdict(list)
with open("timings.csv") as f:
    for row in csv.DictReader(f):
        times[(int(row["n"]), row["threads"])].append(float(row["seconds"]))
t = {key: median(values) for key, values in times.items()}

sizes = sorted({n for n, _ in t})
threads = sorted({int(p) for _, p in t if p != "serial"})

fig, (left, right) = plt.subplots(1, 2, figsize=(10, 4.2))

# Left: time against N
left.loglog(sizes, [t[(n, "serial")] for n in sizes], "ks--", label="serial (ex1)")
for p in threads:
    left.loglog(sizes, [t[(n, str(p))] for n in sizes], "o-", label=f"{p} thread{'s' if p > 1 else ''}")
n0, t0 = sizes[0], t[(sizes[0], "serial")]
left.loglog(sizes, [2 * t0 * (n / n0) ** 2 for n in sizes], "k:", lw=1, label=r"$\propto N^2$")
left.set_xlabel("number of particles N")
left.set_ylabel("wall-clock time (s)")
left.set_title("Run time (median of the runs)")
left.legend(fontsize=8)

# Right: speed-up against the number of threads
right.plot(threads, threads, "k:", lw=1, label="ideal")
for n in sizes:
    right.plot(threads, [t[(n, "1")] / t[(n, str(p))] for p in threads], "o-", label=f"N = {n}")
right.set_xticks(threads)
right.set_yticks(threads)
right.set_xlabel("threads p")
right.set_ylabel("speed-up T(1) / T(p)")
right.set_title("Speed-up of ex1_omp")
right.legend(fontsize=8)

fig.tight_layout()
fig.savefig("timing.png", dpi=130)
print("wrote timing.png")
