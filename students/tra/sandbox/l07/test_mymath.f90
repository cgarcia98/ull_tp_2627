! Program to test the module mymath

program test_mymath
    use kinds, only: dp
    use mymath, only: circle_area
    use stats, only: mean_and_std
    implicit none

    real(kind=dp) :: radius
    real :: mean, std
    real :: array(5) = [1.0, 2.0, 3.0, 4.0, 5.0]

    write (*, *) "Enter a value of radius of a circle to calculate its area:"
    read (*, *) radius
    print *, "Circle area: ", circle_area(radius)

    ! adding the stats module calculations to the test_mymath file
    print *
    print *, "Mean and std from stats module for array given: "
    call mean_and_std(array, mean, std)

end program test_mymath