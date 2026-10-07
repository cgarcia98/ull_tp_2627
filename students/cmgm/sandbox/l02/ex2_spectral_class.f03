program spectral_classification
    implicit none
    integer :: t_eff                ! effective temperature (K)
    character(len=1) :: spectral_class

    t_eff = 5772                    ! Sun

    select case (t_eff)
    case (30000:)
        spectral_class = 'O'
    case (10000:29999)
        spectral_class = 'B'
    case (7500:9999)
        spectral_class = 'A'
    case (6000:7499)
        spectral_class = 'F'
    case (5200:5999)
        spectral_class = 'G'
    case (3700:5199)
        spectral_class = 'K'
    case (2400:3699)
        spectral_class = 'M'
    case default
        spectral_class = ' '        ! outside the sequence
    end select

    if (spectral_class == ' ') then
        print *, "Temperature outside the spectral sequence (O-M)."
    else
        print *, "Spectral class: " // spectral_class
    end if
end program spectral_classification
