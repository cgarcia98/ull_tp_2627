! Program to print a table of the peak emission wavelength of a blackbody for a series of temperatures

program wien_law

    implicit none
    integer :: i
    integer, parameter :: initial=3000, final=30000, step=3000

    ! do loop to print the values of wavelength peak emission from the temperatures
    print *
    print *, "Loops with b as a real type constant:"
    print *, "-------------------------------------"
    print *, "Looop from coldest to hottest: "
    do i=initial, final, step
        write (*, "(a, i6, a, i5, a, a, f8.2, a)") "Iteration variable: ", i, &
                                                   " | Temperature: ", i, " (K) | ", &
                                                   "Wavelength peak emission: ", wavelength(i), " (nm)"
    end do

    print *
    print *, "Loop from hottest to coldest: "

    ! reverse do loop using a negative step
    do i=final, initial, -step
        write (*, "(a, i6, a, i5, a, a, f8.2, a)") "Iteration variable: ", i, &
                                                   " | Temperature: ", i, " (K) | ", &
                                                   "Wavelength peak emission: ", wavelength(i), " (nm)"
    end do

    ! here we repeat the loops and see what happens if we set b as an integer constant with the help of the second function defined
    print *
    print *, "Loops with b as an integer constant:"
    print *, "-------------------------------------"
    print *, "Looop from coldest to hottest: "
    do i=initial, final, step
        write (*, "(a, i6, a, i5, a, a, f8.2, a)") "Iteration variable: ", i, &
                                                   " | Temperature: ", i, " (K) | ", &
                                                   "Wavelength peak emission: ", wavelength_int_b(i), " (nm)"
    end do

    print *
    print *, "Loop from hottest to coldest: "

    ! reverse do loop using a negative step
    do i=final, initial, -step
        write (*, "(a, i6, a, i5, a, a, f8.2, a)") "Iteration variable: ", i, &
                                                   " | Temperature: ", i, " (K) | ", &
                                                   "Wavelength peak emission: ", wavelength_int_b(i), " (nm)"
    end do

contains
    real function wavelength(t)
    !!  function to calculate wavelength peak emission given a temperature

    !! arguments
    integer, intent(in) :: t 
        !! (in) temperature of the blackbody
    real, parameter :: b = 2.897772e6 ! (nm K)
        !! Wien's law proportionality constant

        wavelength = b/t ! (nm)

        return
    end function wavelength

    real function wavelength_int_b(t)
    !!  function to calculate wavelength peak emission given a temperature
    !! but here b is an integer constant

    !! arguments
    integer, intent(in) :: t 
        !! (in) temperature of the blackbody
    integer, parameter :: b = 2897772 ! (nm K)
        !! Wien's law proportionality constant

        wavelength_int_b = b/t ! (nm)

        return
    end function wavelength_int_b

end program wien_law