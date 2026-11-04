program habitable_zone
    implicit none

    real :: L, a, e, r_in, r_out, periapsis, apoapsis
    logical :: apoapsis_in_zone, periapsis_in_zone

    L = 1.0
    a = 1.524
    e = 0.093


    if (e < 0.0 .or. e >= 1.0) then
        stop "Error: Eccentricity must be between 0 and 1!"
    end if

    r_in = sqrt(L/1.1)
    r_out = sqrt(L/0.53)
    periapsis = a*(1-e)
    apoapsis = a*(1+e)

    if (periapsis > r_in .and. periapsis < r_out) then 
        periapsis_in_zone = .true.
    else  
        periapsis_in_zone = .false.
    end if

    if (apoapsis > r_in .and. apoapsis < r_out) then 
        apoapsis_in_zone = .true.
    else  
        apoapsis_in_zone = .false.
    end if

    if (periapsis_in_zone .and. apoapsis_in_zone) then
        print *, "always."
    else if (periapsis_in_zone .neqv. apoapsis_in_zone) then
        print *, "partly."
    else if (periapsis < r_in .and. apoapsis > r_out) then
        print *, "partly."
    else
        if (apoapsis > r_out) then
            print *, "too cold."
        else
            print *, "too hot."
        end if
    end if

end program