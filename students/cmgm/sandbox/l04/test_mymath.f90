program test_mymath
    use kinds, only: dp
    use mymath
    implicit none
    real(dp) :: r

    r = 2.0_dp
    print *, "Area of a circle with radius", r, "is", circle_area(r)
end program test_mymath
