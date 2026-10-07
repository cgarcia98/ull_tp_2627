! Program to report wether a planet is always, partly or never in the habitable zone (and also whether it is too hot or cold)
! given its luminosity, semi-major axis and eccentricity

program habitable_zone

    implicit none
    real :: luminosity
    real :: semi_major_axis
    real :: eccentricity

    ! ask the user for the data
    write (*, "(a)") "Enter the value of the luminosity of the (solar units):"
    read (*, *) luminosity
    write (*, "(a)") "Enter the value of the semi-majora axis of the planet (AU):"
    read (*, *) semi_major_axis
    write (*, "(a)") "Enter the value of the eccentricity of the planet:"
    read (*, *) eccentricity
    if (luminosity <= 0.0 .or. semi_major_axis <= 0.0) stop "Luminosity and semi-major axis must be positive values. Try again."
    if (eccentricity < 0.0 .or. eccentricity >= 1.0) stop "Eccentricity must be in the range 0 <= e < 1. Try again."

    ! printing the information that has been input
    print *
    write (*, "(a, f8.3, a, a, f8.3, a, a, f8.3)") "Star's luminosity: ", luminosity, " (solar)", &
                                                   " | Planet's semi-major axis: ", semi_major_axis, " (AU)", &
                                                   " | Planet's eccentricity: ", eccentricity

    ! printing the statement of whether the planet is habitable and in what amount (absolutely, partially or never)
    print *
    write (*, *) habitability(luminosity, semi_major_axis, eccentricity)

contains
    character(len=120) function habitability(l, a, e)
    !! function to report the habitability of a planet given the
    !! luminosity of the star, and the semi-major axis and eccentricity of the planet 

    !! arguments
    real, intent(in) :: l
        !! (in) luminosity of the star which the planet orbits (solar luminosity)
    real, intent(in) :: a
        !! (in) semi-major axis of the planet (AU)
    real, intent(in) :: e
        !! (in) eccentricity of the planet
    real :: r_in, r_out
        !! inner and outer habitable zone edges (AU)
    real :: periapsis, apoapsis
        !! periapsis and apoapsis of the planet's orbit (AU)
    logical :: periapsis_condition, apoapsis_condition, whole_crossing_condition
        !! logical variables to see if the habitability condition is fulfilled or not
    
        r_in = sqrt(l/1.1)
        r_out = sqrt(l/0.53)

        periapsis = a*(1-e)
        apoapsis = a*(1+e)

        periapsis_condition = r_in <= periapsis .and. periapsis <= r_out
        apoapsis_condition = r_in <= apoapsis .and. apoapsis <= r_out
        whole_crossing_condition = periapsis < r_in .and. apoapsis > r_out 

        ! if conditions to see if the planet is absolutely, partially or never in the habitable zone
        if (periapsis_condition .and. apoapsis_condition) then
            habitability = "The planet is always in the habitable zone."

        else if ((periapsis_condition .neqv. apoapsis_condition) .or. whole_crossing_condition) then
            habitability = "The planet is partially in the habitable zone."

        else if (apoapsis < r_in) then
            habitability = "The planet is never in the habitable zone. It is too hot."

        else
            habitability = "The planet is never in the habitable zone. It is too cold."
        end if
        
    end function habitability

end program habitable_zone