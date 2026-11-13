# Makefile for course exercise 1: direct N-body simulation.
#
#   make            builds both programs: ex1 (serial) and ex1_omp (OpenMP)
#   make run        builds ex1 and runs it with the figure-eight input
#   make run_omp    the same with ex1_omp (threads: OMP_NUM_THREADS)
#   make random_sphere  builds the generator of initial conditions of the
#                   exercise (used by timing.sh)
#   make clean      removes everything that make has built
#
# Another input file: make run INPUT=my_input.dat

FC = gfortran
FCFLAGS = -Wall -O2

OBJECTS = geometry.o particle.o ex1.o
INPUT = ../../../lectures/exercise_1/input.dat
SPHERE = ../../../lectures/exercise_1/random_sphere.f90

all: ex1 ex1_omp

ex1: $(OBJECTS)
	$(FC) $(FCFLAGS) -o $@ $^

# Only ex1.f90 has OpenMP directives, so the OpenMP program uses the same
# module objects. ex1.f90 is compiled into its own object, ex1_omp.o, so the
# two programs never mix an object built with -fopenmp and one built without
ex1_omp: geometry.o particle.o ex1_omp.o
	$(FC) $(FCFLAGS) -fopenmp -o $@ $^

ex1_omp.o: ex1.f90
	$(FC) $(FCFLAGS) -fopenmp -c $< -o $@

%.o: %.f90
	$(FC) $(FCFLAGS) -c $<

# Module dependencies
particle.o: geometry.o
ex1.o ex1_omp.o: geometry.o particle.o

.PHONY: all run run_omp clean

run: ex1
	./ex1 $(INPUT)

run_omp: ex1_omp
	./ex1_omp $(INPUT)

random_sphere: $(SPHERE)
	$(FC) $(FCFLAGS) -o $@ $<

clean:
	rm -f *.o *.mod ex1 ex1_omp random_sphere output.dat
