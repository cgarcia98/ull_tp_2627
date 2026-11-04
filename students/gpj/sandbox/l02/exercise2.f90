program spectral_classification
    implicit none
    integer :: T
    character(len=1) :: clase

    print *, "Set the effective temperature (T) of the star in Kelvin:"
    read *, T
    
    select case (T)
        case (30000:)
            clase = 'O'
        case (10000:29999)
            clase = 'B'
        case (7500:9999)
            clase = 'A'
        case (6000:7499)
            clase = 'F'
        case (5200:5999)
            clase = 'G'
        case (3700:5199)
            clase = 'K'
        case (2400:3699)
            clase = 'M'
        case default
            clase = 'X'
    end select

    if (clase == 'X') then
        print *, "Error: Temperature outside the spectral sequence."
    else
        print *, "The spectral class of the star is: " // clase
    end if

end program spectral_classification