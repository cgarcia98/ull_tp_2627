# Course exercise 1: N-body simulation with OpenMP

Gravity simulation of N particles with the leapfrog (kick-drift-kick)
method. The force calculation runs in parallel with OpenMP.

## Files

- `geometry.f90`: module with the types `vector3d` and `point3d`, their functions and operators, and `distance`.
- `particle.f90`: module with the type `particle3d` (position `p`, velocity `v`, mass `m`).
- `ex1.f90`: the main program. Reads the input file, runs the simulation, and writes `output.dat`.
- `makefile`: builds the serial program `ex1` and the OpenMP program `ex1_omp`.
- `timing.sh`: the timing study. `plot_timings.py` makes `timing.png` from its results (`timings.csv`).

## Compile and run

```bash
make            # builds ex1 and ex1_omp
make run        # runs ex1 with lectures/exercise_1/input.dat
make clean      # removes the compiled files and output.dat
```

With any other input file:

```bash
./ex1 input.dat
OMP_NUM_THREADS=4 ./ex1_omp input.dat
```

The input file has `dt`, `dt_out`, `t_end`, and `n` on the first four lines,
and then one line `m x y z vx vy vz` per particle. Each line of `output.dat`
is `t p1x p1y p1z ... pnx pny pnz`, first at t = 0 and then every `dt_out`.
The program also prints the wall-clock time of the simulation.

## How it works

- `point3d` and `vector3d` are separate types, so the compiler rejects things like adding two points. Besides the functions of the exercise, `geometry` has `sumvv` (vector + vector), which the leapfrog step needs.
- Each step is a half kick, a drift, the new accelerations, and another half kick. The accelerations are computed once per step.
- For OpenMP, each particle sums the forces of all the others, so each thread only writes the accelerations of its own particles and there is no race condition. Each pair is computed twice, but the results are exactly the same with and without OpenMP.

## Test

With `input.dat`, the three bodies follow the figure-eight orbit and come back
to their starting points about every 6.33 time units. `output.dat` is identical
for `ex1` and for `ex1_omp` with 1, 2, 4, and 8 threads.

## Timing study

`./timing.sh` creates the particles with `random_sphere` (seed 42) with
`dt = 0.001` and `t_end = dt_out = 0.1` (100 steps), and runs each case three
times. The times are the medians, measured on a laptop with an AMD Ryzen 7
7840HS (8 cores) and `-O2`.

| N | serial | 1 thread | 2 threads | 4 threads | 8 threads |
|---|---|---|---|---|---|
| 1000 | 0.63 s | 0.69 s | 0.36 s | 0.18 s | 0.10 s |
| 2000 | 2.54 s | 2.73 s | 1.37 s | 0.71 s | 0.41 s |
| 5000 | 15.70 s | 17.00 s | 8.61 s | 4.52 s | 2.71 s |
| 10000 | 63.13 s | 68.44 s | 34.81 s | 17.57 s | 10.11 s |

Speed-up compared with one thread:

| N | 2 threads | 4 threads | 8 threads |
|---|---|---|---|
| 1000 | 1.9 | 3.8 | 6.8 |
| 2000 | 2.0 | 3.8 | 6.7 |
| 5000 | 2.0 | 3.8 | 6.3 |
| 10000 | 2.0 | 3.9 | 6.8 |

- The time grows as N²: doubling N makes the run about four times longer.
- With 2 and 4 threads, the speed-up is almost ideal.
- With 8 threads it is about 6.5. With all the cores busy, the processor runs at a lower clock speed, and other programs on the laptop also interrupt the threads.
- `ex1_omp` on one thread is about 8 % slower than `ex1`.
- With only the three bodies of `input.dat`, `ex1_omp` is slower than `ex1`, because each step has too little work to share between threads.
