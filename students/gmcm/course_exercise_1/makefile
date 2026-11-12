# Makefile for course exercise 1: direct N-body simulation.
#
#   make            builds the program ex1
#   make run        builds ex1 and runs it with the figure-eight input
#   make clean      removes everything that make has built
#
# Another input file: make run INPUT=my_input.dat

FC = gfortran
FCFLAGS = -Wall -O2

OBJECTS = geometry.o particle.o ex1.o
INPUT = ../../../lectures/exercise_1/input.dat

ex1: $(OBJECTS)
	$(FC) $(FCFLAGS) -o $@ $^

%.o: %.f90
	$(FC) $(FCFLAGS) -c $<

# Module dependencies: a file is compiled after the modules that it uses
particle.o: geometry.o
ex1.o: geometry.o particle.o

.PHONY: run clean

run: ex1
	./ex1 $(INPUT)

clean:
	rm -f *.o *.mod ex1 output.dat
