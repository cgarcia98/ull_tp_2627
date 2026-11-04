! Program to test the module mymath

program test_mymath
    use kinds, only: dp
    use mymath, only: circle_area
    implicit none
    real(kind=dp) :: radius

    write (*, *) "Enter a value of radius of a circle to calculate its area:"
    read (*, *) radius
    print *, circle_area(radius)

end program test_mymath