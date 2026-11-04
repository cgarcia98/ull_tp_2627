# Makefile for the mymath program of lecture 4
# test_mymath.f90 program uses the mymath.mod and kinds.mod modules

# rewriting with variables and pattern rules
FC = gfortran
FCFLAGS = -Wall -fcheck=all 
OBJECTS = kinds.o mymath.o stats.o test_mymath.o

test_mymath: $(OBJECTS)
	$(FC) -o $@ $^

# using the pattern rule
%.o: %.f90
	$(FC) $(FCFLAGS) -c $<

# adding the extra dependencies that some object files need
mymath.o: kinds.o

test_mymath.o: kinds.o mymath.o stats.o

clean: 
	rm -f *.o *.mod test_mymath

test: test_mymath
	./test_mymath


