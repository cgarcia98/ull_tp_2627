! Program to calculate the period of a planet given its semi-major axis (a) and its mass (M) in solar masses.
! The period will be calculated in years, days and as a whole number of days.
! We also take advantage of this exercise to play a bit with writing, reading and writing proper documentation for functions.

program kepler_third_law
    
    implicit none
    real :: semi_major_axis, star_mass, period_value
    real, parameter :: days_in_year = 365.25

    ! just to make it a bit more complex i will ask the user to input the values of the variables to practice with writing and reading
    ! and the formatting in the printing of the results
    write (* , "(a)") "Enter the values of the semi-major axis of the planet (AU): "
    read (*, *) semi_major_axis
    write (* , "(a)") "Enter the values of the mass of the star (solar mass): "
    read (*, *) star_mass
    if (semi_major_axis <= 0 .or. star_mass <= 0) stop "Enter positive values to both entries. Try again."

    ! in this snippet we print the results of the calculation
    period_value = period(semi_major_axis, star_mass)
    print *
    print *, "Table"
    print *, "------------------------------------------------------------------"
    write (*, "(a, f8.3, a, f8.3)") "Semi-major axis (AU): ", semi_major_axis, &
                                    " | Mass (solar masses): ", star_mass 
    write (*,  "(a, f8.3, a, f8.3, a, i6)") " Period (years): ", period_value, & 
                                            " | Period (days): ", days_in_year*period_value, &
                                            " | Period (days integer): ", int(days_in_year*period_value)

contains
    function period(a, m)
    !! function to calculate the orbital period of the planet in years
    !! given its semi-major axis and the mass of the star it orbits
    
    !! arguments
    real, intent(in) :: a
        !! (in) the semi-major axis of the planet (AU)
    real, intent(in) :: m
        !! (in) the mass of the star (solar masses)
    real :: period
        !! (return) period of the planet (years)
    
        period = sqrt(a**3/m) ! in years

    end function period

end program kepler_third_law