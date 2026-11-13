#!/usr/bin/env bash
# Timing study for course exercise 1.
#
# 1. Creates the initial conditions with random_sphere for each number of
#    particles N, always with the same seed, so every run uses the same
#    particles. dt_out is set equal to t_end, so that writing the output
#    does not dominate the run time.
# 2. Runs the serial program ex1, and ex1_omp with 1, 2, 4, and 8 threads.
#    Every case runs REPEATS times, and the table uses the median time.
#
# Run it from this folder:   ./timing.sh
# A short test run:          SIZES="200 400" REPEATS=1 ./timing.sh
#
# Results: timings.csv with every run, and a Markdown table on the screen
# with the median wall-clock times, the speed-ups S(p) = T(1)/T(p), and the
# efficiencies E(p) = S(p)/p, where T(1) is ex1_omp with one thread.

set -euo pipefail

# Decimal points, not commas, in printf and sort, whatever the language of
# the system (the program writes its times with a decimal point)
export LC_ALL=C

SIZES=${SIZES:-"1000 2000 5000 10000"}
THREADS=${THREADS:-"1 2 4 8"}
REPEATS=${REPEATS:-3}
SEED=42

# One thread per physical core, and the threads stay on their cores
export OMP_PROC_BIND=close OMP_PLACES=cores

make ex1 ex1_omp random_sphere

# Initial conditions, with dt_out = t_end (line 2 = line 3)
for n in $SIZES; do
    ./random_sphere "$n" "$SEED" > "sphere_$n.dat"
    t_end=$(sed -n 3p "sphere_$n.dat")
    sed -i "2s/.*/$t_end/" "sphere_$n.dat"
done

# The runs. Each repetition goes through all the cases, so that a slow
# moment of the computer does not affect only one case
echo "n,threads,run,seconds" > timings.csv
for run in $(seq "$REPEATS"); do
    for n in $SIZES; do
        s=$(./ex1 "sphere_$n.dat" | awk '/Wall time:/ {print $3}')
        echo "$n,serial,$run,$s" >> timings.csv
        echo "run $run, N = $n, serial: $s s"
        for p in $THREADS; do
            s=$(OMP_NUM_THREADS=$p ./ex1_omp "sphere_$n.dat" | awk '/Wall time:/ {print $3}')
            echo "$n,$p,$run,$s" >> timings.csv
            echo "run $run, N = $n, threads = $p: $s s"
        done
    done
done

# Median of the times in timings.csv for N = $1 and threads = $2
median() {
    awk -F, -v n="$1" -v p="$2" '$1 == n && $2 == p {print $4}' timings.csv | sort -g |
        awk '{t[NR] = $1} END {print (NR % 2) ? t[(NR + 1) / 2] : (t[NR / 2] + t[NR / 2 + 1]) / 2}'
}

# The table: time, and for the OpenMP runs (speed-up, efficiency)
echo
printf '| N | serial |'
for p in $THREADS; do
    if [ "$p" = 1 ]; then printf ' 1 thread |'; else printf ' %s threads |' "$p"; fi
done
printf '\n|---|---|'
for p in $THREADS; do printf -- '---|'; done
printf '\n'
for n in $SIZES; do
    t1=$(median "$n" 1)
    printf '| %s | %.3f s |' "$n" "$(median "$n" serial)"
    for p in $THREADS; do
        tp=$(median "$n" "$p")
        awk -v t1="$t1" -v tp="$tp" -v p="$p" \
            'BEGIN {printf " %.3f s (%.2f, %.0f %%) |", tp, t1 / tp, 100 * t1 / tp / p}'
    done
    printf '\n'
done
