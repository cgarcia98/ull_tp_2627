program kepler_third_law
    implicit none

    real, parameter :: year = 365.25
    real :: a = 5.2 !AU, semimajor axis
    real :: mass = 1.0 !solar masses
    real :: period
    integer :: P

    if (a < 0.0 .or. mass <= 0.0) then
        stop "Error: Values for semimajor axis and mass must be positive!"
    end if

    period = sqrt(a**3/mass) * year

    P = int(period)

    print *, "The period is", P, "days."

end program