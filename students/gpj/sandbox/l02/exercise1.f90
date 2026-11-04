module kepler_module
    implicit none
contains
    real function calculate_period(a, M)
        real, intent(in) :: a, M
        calculate_period = sqrt(a**3 / M)
    end function calculate_period
end module kepler_module

program kepler
    use kepler_module
    implicit none
    real :: a, M
    real, parameter :: d = 365.25
    print *, "Enter the semi-major axis (a) in AU: "
    read *, a
    if (a <= 0.0) then
        print *, "Error: The semi-major axis must be a positive number."
        stop
    end if
    print *, "Enter the mass of the central body (M) in solar masses: "
    read *, M
    if (M <= 0.0) then
        print *, "Error: The mass of the central body must be a positive number."
        stop
    end if
    print *, "The orbital period P in years is: ", calculate_period(a, M)
    print *, "The orbital period P in days is: ", calculate_period(a, M) * d
    print *, "The orbital period P as a whole number of days is: ", int(calculate_period(a, M) * d)
end program kepler