program spectral_classification
    implicit none

    integer :: temperature = 24000 !AU, semimajor axis
    character(len=1) :: star_name

    select case (temperature)
    case (30000:)
        star_name = "O"
    case (10000:29999) 
        star_name = "B"
    case (7500:9999)
        star_name = "A"
    case (6000:7499)
        star_name = "F"
    case (5200:5999)
        star_name = "G"
    case (3700:5199)
        star_name = "K"
    case (2400:3699)
        star_name = "M"
    case (:2399)
        print *, "Not a Star"
    end select

    print *, "Spectral class: " // star_name

end program