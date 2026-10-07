# Solutions to the Lecture 2 exercises
#
#   make        compile all the programs
#   make test   run each program
#   make clean  remove the executables
#
# The programs do not read input. To test another case, change the input
# values at the top of a program and run make again.

FC = gfortran
FCFLAGS = -Wall -fcheck=all -std=f2008
PROGRAMS = kepler_third_law spectral_class habitable_zone wien_table kepler_equation

all: $(PROGRAMS)

%: %.f90
	$(FC) $(FCFLAGS) -o $@ $<

test: all
	./kepler_third_law
	./spectral_class
	./habitable_zone
	./wien_table
	./kepler_equation

clean:
	rm -f $(PROGRAMS) *.o *.mod

.PHONY: all test clean
