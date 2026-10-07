module keplers_law_module
    implicit none
contains
    function kepler_period(a, m_star)
        real, intent(in) :: a, m_star
        real :: kepler_period
        kepler_period = sqrt(a**3 / m_star)
        !kepler_period_days = kepler_period_years * d ! convert to days
    if (a <= 0.0 .or. m_star <= 0.0) then
        print *, "Error: Semi-major axis and mass of the star must be positive."
        kepler_period = -1.0 ! return an error value
    end if
    end function kepler_period
end module keplers_law_module

program keplers_law
    use keplers_law_module
    implicit none
    real, parameter :: days_in_a_year = 365.25 ! days in a year
    real :: a, m_star
    a = 5.2
    m_star = 1.0
    !print *, "Hi, please enter the semi-major axis (in AU) and the mass of the star (in solar masses)."
    !read *, a, m_star

    print *, "The orbital period is:", kepler_period(a, m_star) * days_in_a_year
    print *, "The orbital period in years is:", kepler_period(a, m_star)
end program keplers_law